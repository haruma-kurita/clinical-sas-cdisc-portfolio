libname sdtm "C:\Users\kuric\Desktop\cdisc-portfolio\data_sdtm";
libname adam "C:\Users\kuric\Desktop\cdisc-portfolio\data_adam";
libname raw "C:\Users\kuric\Desktop\cdisc-portfolio\data_raw";

proc print data=raw.dm_large (obs=10);
	var BRTHDTC;
run;

proc freq data=raw.dm_large order=freq;
	tables BRTHDTC / maxlevels=15 missing;
run;

data adam.adsl;
	set sdtm.dm;

	if SEX = "M" then SEXN = 1;
	else if SEX = "F" then SEXN = 2;
	else SEXN = 99;

	if BRTHDTC ^= "" then BRTHDT = input(BRTHDTC, yymmdd10.);
	if BRTHDT ^= . then AGE = floor(yrdif(BRTHDT, '01JAN2026'd, 'AGE'));
	format BRTHDT date9.;
run;

proc means data=adam.adsl n nmiss mean min max;
	var AGE;
run;

