libname adam "C:\Users\kuric\Desktop\cdisc-portfolio\data_adam";

title1 "Table 14.3.1: Incidence of Adverse Events by Sex";
title2 "Safety Population (N=500,000)";

proc report data=adam.adae nowindows missing split='|';
    
    /* Define the columns: Group by AEDECOD, and create across-columns for SEX */
    column AEDECOD SEX, (N);
    
    /* Format the rows and headers */
    define AEDECOD / group "Adverse Event | (MedDRA Preferred Term)" width=40 left;
    define SEX / across "Patient Sex";
    define N / "Event Count" format=comma9. center;
run;

title;
