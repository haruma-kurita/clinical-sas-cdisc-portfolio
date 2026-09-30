/* 1. Define the library where your final SAS datasets will live */
/* Update the path below to point to your data_raw folder */
libname rawdata "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw";

/* 2. Define the XPORT engine pointing directly to the downloaded file */
libname xpt_dm xport "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw\dm.xpt";

/* 3. Copy the transport file into a usable SAS dataset */
proc copy in=xpt_dm out=rawdata;
run;

/* 4. Verify the data loaded correctly */
proc contents data=rawdata.dm;
run;

proc print data=rawdata.dm (obs=10);
run;

%macro multiply_dm(indata=, outdata=, target_rows=);
  /* Dynamically capture the number of rows in the base dataset */
  data _null_;
    set &indata nobs=total_obs;
    call symputx('base_n', total_obs);
    stop;
  run;
  
/* Generate the massive dataset in a single pass */
  data &outdata;
    length SUBJID $15 USUBJID $40 SEX $6 BRTHDTC $10; /* Expanded lengths to allow typos and standard dates */
    drop i iteration rand_err;
    
    total_loops = ceil(&target_rows / &base_n);
    
    do iteration = 1 to total_loops;
      do i = 1 to &base_n;
        set &indata point=i;
        
        /* A. Ensure Unique Subject IDs */
        SUBJID = cats(put(iteration, z4.), "-", SUBJID);
        USUBJID = catx("-", STUDYID, SUBJID);
        
        /* B. Inject Random Technical Errors and Valid Dates */
        rand_err = rand("Uniform");
        
        if rand_err < 0.05 then BRTHDTC = "Unknown";
        else if rand_err < 0.10 then BRTHDTC = ""; 
        else BRTHDTC = put('01JAN1945'd + rand('integer', 1, 21900), yymmdd10. -l); /* Generates valid ISO date */
        
        if rand_err > 0.90 and rand_err <= 0.95 then SEX = "Male"; 
        else if rand_err > 0.95 then SEX = "Femail"; 
        
        /* C. Inject Exact Duplicates */
        output; 
        if rand_err < 0.02 then output; 
        
      end;
    end;
    stop; 
  run;
%mend;

/* Execute the macro to generate the 500,000 rows */
%multiply_dm(indata=rawdata.dm, outdata=rawdata.dm_large, target_rows=500000);

proc contents data=rawdata.dm_large;
run;
