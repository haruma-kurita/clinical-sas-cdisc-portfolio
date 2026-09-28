Clinical SAS Programming Portfolio: CDISC SDTM & ADaM Pipeline
Project Overview
This repository demonstrates an end-to-end clinical trial data processing workflow using SAS. To simulate an enterprise-level clinical programming environment, a baseline PhUSE pilot dataset was programmatically expanded to 500,000 records. This synthetic dataset contains intentionally injected data anomalies—including duplicate records, categorical typos, and truncation errors—to stress-test downstream cleaning logic and demonstrate production-level memory management.

The pipeline cleans, standardizes, and maps this raw data into CDISC-compliant Study Data Tabulation Model (SDTM) and Analysis Data Model (ADaM) datasets, preparing it for biostatistical modeling.

Directory Structure
data_raw/: Contains the initial, uncleaned 500,000-row synthetic dataset (Git ignored due to file size limits).

data_sdtm/: Houses the cleaned, CDISC-compliant SDTM domains.

data_adam/: Houses the derived ADaM analysis datasets.

Pipeline Architecture & Scripts
1. Data Ingestion & Simulation (01_setup_and_multiplier.sas)
Uses SAS macros to scale raw PhUSE data up to 500,000 rows.

Intentionally injects duplicate records, structural string errors (e.g., "Femail"), and truncation limits to mimic real-world data entry anomalies from Electronic Data Capture (EDC) systems.

2. SDTM Demographics Mapping (02_sdtm_dm.sas)
Deduplication: Executes one-to-one record deduplication using PROC SORT NODUPKEY, creating an audit trail of dropped duplicates.

Data Standardization: Applies defensive IF/THEN/ELSE logic to clean categorical typos in the SEX variable, enforcing standard CDISC terminology.

Validation: Cleans and validates ISO 8601 date formats (BRTHDTC) using nested LENGTH and STRIP functions.

Domain Compliance: Enforces strict SDTM structural compliance using the KEEP statement to retain only required domain variables.

3. ADaM Subject-Level Analysis Dataset (03_adam_adsl.sas) — In Progress
Derives numeric analysis variables (e.g., SEXN) from categorical SDTM variables to prepare the data for efficient statistical modeling.

Technical Competencies Demonstrated
SAS Base Programming: Data Step logic, conditional processing, and macro utilization.

Data Validation: Frequency analysis (PROC FREQ) and metadata inspection (PROC CONTENTS).

Clinical Standards: CDISC SDTM (Implementation Guide compliance) and ADaM dataset architecture.

Version Control: Command Line Interface (CLI) Git management and repository maintenance.