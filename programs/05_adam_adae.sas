/* Define libraries */
libname sdtm "C:\Users\kuric\Desktop\cdisc-portfolio\data_sdtm";
libname adam "C:\Users\kuric\Desktop\cdisc-portfolio\data_adam";

/* 1. Sort the Demographics (ADSL) dataset by Subject ID */
proc sort data=adam.adsl out=adsl_srt;
    by USUBJID;
run;

/* 2. Sort the Adverse Events (SDTM AE) dataset by Subject ID */
proc sort data=sdtm.ae out=ae_srt;
    by USUBJID;
run;

/* 3. Merge AE with ADSL to create the foundation of ADAE */
data adam.adae;
    /* 'in=a' and 'in=b' create temporary flags indicating if a patient exists in that specific dataset */
    merge ae_srt (in=a) adsl_srt (in=b);
    by USUBJID;
    if a; 
run;

/* 4. Verify the merge pulled the demographics successfully */
proc print data=adam.adae (obs=10);
    var USUBJID AESEQ AETERM AEDECOD AGE SEXN;
run;
