libname raw "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw";
libname sdtm "C:\Users\kuric\Desktop\cdisc-portfolio\data_sdtm";
libname xpt_ae xport "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw\ae.xpt";

proc copy in=xpt_ae out=raw;
run;

proc print data=raw.ae(obs=10);
run;

data sdtm.ae;
	set raw.ae;
	AETERM = strip(AETERM);
	AEEDCOD = strip(AEDECOD);
	keep STUDYID DOMAIN USUBJID AESEQ AETERM AEDECOD;
run;

proc sort data=sdtm.ae;
	by USUBJID AESEQ;
run;

proc contents data=sdtm.ae;
run;
