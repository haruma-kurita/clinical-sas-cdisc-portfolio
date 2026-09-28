/* Define the library to access the raw data */
libname rawdata "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw";
libname sdtm "C:\Users\kuric\Desktop\cdisc-portfolio\data_sdtm";

proc sort data=rawdata.dm_large out=work.dm_clean DUPOUT=work.dm_dups NODUPKEY;
	by usubjid;
run;

data sdtm.dm;
	/* Task 1: Standardize the SEX variable */
	set work.dm_clean;
	if SEX = "Male" then SEX = "M";
	else if SEX = "Femail" then SEX = "F";
	else if SEX not in ("M", "F", "U") then SEX = "U";

	/* Task 2: Validate BRTHDTC */
	if length(strip(BRTHDTC)) ^= 10 then BRTHDTC = "";

	/* Task 3: Enforce Domain Structure */
	keep STUDYID DOMAIN USUBJID SUBJID SITEID BRTHDTC SEX;


run;

proc contents data=sdtm.dm; run;
