# Predicting Sepsis in the Intensive Care Unit

Ryan Quan (rcq2102@columbia.edu)  
Frank Chen (fc2451@columbia.edu)

[Github Repo](https://www.github.com/frankchen07/binf-project)

## About

This project will focus on developing a prediction model for the onset of sepsis in the ICU using clinical history and non-invasive physiological data obtained in the first six hours of admission. Using a large dataset of patients, routine clinical measurements obtained during initial stages of care, new imputation techniques, and data mining methodologies, the goal will be to facilitate advance warning of sepsis in the general critical care setting.

## File Directory

* `data`
    - `sql_dump.RData` - workspace image of initial pull from MIMIC II DB
* `docs`
    - `references` - BibTeX reference library and Citation Style Languages
* `R`
    - `sepsis_files` - plots generated from `sepsis.Rmd`
    - sepsis.Rmd - reproducible `knitr` document containing load, transform, and analysis scripts with writeup in markdown
    - sepsis.pdf - AMIA format report
* `sql`
    - mimic_to_csv.sql - (do not use) initial attempt to pull from MIMIC II DB
    - sepsis_summary.sql - (do not use) unique subject ids for analysis

## How to Use

1. Open the `sepsis.Rmd` file in RStudio.
2. Click `Knit PDF`.
3. Enjoy reproducible research.

## Considerations

* Evaluation of code chunks with SQL queries has been set to `FALSE` to reduce runtime and load to the instance of the MIMIC II DB.
* MIMIC II data read into R via `RPostgreSQL` has been saved as a workspace image named `sql_dump.RData` for convenience.
* `sepsis.Rmd` must load `sql_dump.RData` in order to run the analysis
* `sepsis.Rmd` fits 180 models and requires about 30 minutes to run to completion using a dual-core processor.
* Final outputs of `sepsis.Rmd` are 1) pdf report and 2) cached plots.
