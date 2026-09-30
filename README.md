# 📊 Clinical SAS Programming Portfolio: CDISC SDTM & ADaM Pipeline

**Author:** Haruma Kurita | SAS Certified Specialist: Base Programming Using SAS 9.4 | MS Biostatistics Candidate

> **Project Overview**
> This repository demonstrates an end-to-end clinical trial data processing workflow using SAS. To simulate an enterprise-level clinical programming environment, a baseline PhUSE pilot dataset was programmatically expanded to 500,000 records. This synthetic dataset contains intentionally injected data anomalies—including duplicate records, categorical typos, and truncation errors—to stress-test downstream cleaning logic and demonstrate production-level memory management.
> 
> The pipeline cleans, standardizes, and maps this raw data into CDISC-compliant Study Data Tabulation Model (SDTM) and Analysis Data Model (ADaM) datasets, preparing it for biostatistical modeling.

## 📁 Directory Structure
*   `data_raw/`: Contains the initial, uncleaned 500,000-row synthetic dataset *(Git ignored due to file size limits)*.
*   `data_sdtm/`: Houses the cleaned, CDISC-compliant SDTM domains.
*   `data_adam/`: Houses the derived ADaM analysis datasets.

---

## ⚙️ Pipeline Architecture & Scripts

### 1. Data Ingestion & Simulation (`01_setup_and_multiplier.sas`)
*   Uses SAS macros to scale raw PhUSE data up to 500,000 rows.
*   Intentionally injects duplicate records, structural string errors (e.g., "Femail"), and truncation limits to mimic real-world data entry anomalies from Electronic Data Capture (EDC) systems.

### 2. SDTM Demographics Mapping (`02_sdtm_dm.sas`)
*   **Deduplication:** Executes one-to-one record deduplication using `PROC SORT NODUPKEY`, creating an audit trail of dropped duplicates.
*   **Data Standardization:** Applies defensive `IF/THEN/ELSE` logic to clean categorical typos in the `SEX` variable, enforcing standard CDISC terminology.
*   **Validation:** Cleans and validates ISO 8601 date formats (`BRTHDTC`) using nested `LENGTH` and `STRIP` functions.
*   **Domain Compliance:** Enforces strict SDTM structural compliance using the `KEEP` statement to retain only required domain variables.

### 3. ADaM Subject-Level Analysis Dataset (`03_adam_adsl.sas`)
*   **Numeric Mappings:** Derives numeric analysis variables (e.g., `SEXN`) from categorical SDTM domains for statistical modeling.
*   **Date Conversions & Math:** Transforms ISO 8601 character strings into numeric SAS dates and calculates precise biological `AGE` using the `YRDIF` function relative to study milestones.
*   **Defensive Programming:** Safely intercepts missing or invalid upstream data (e.g., simulated missing birth dates) and maps them to appropriate SAS missing values (`.`), preventing downstream calculation failures.

---

## 🚀 Technical Competencies Demonstrated
*   **SAS Base Programming:** Data Step logic, conditional processing, and macro utilization.
*   **Data Validation:** Frequency analysis (`PROC FREQ`) and metadata inspection (`PROC CONTENTS`).
*   **Clinical Standards:** CDISC SDTM (Implementation Guide compliance) and ADaM dataset architecture.
*   **Version Control:** Command Line Interface (CLI) Git management and repository maintenance.

---
*AI Usage Disclosure: Google Gemini was utilized as a thought partner to structure this repository and format project documentation.*
