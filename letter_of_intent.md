---
title: Project Letter of Intent
author: Ryan Quan, Frank Chen
date: 2015-02-23
---

## Declaration of Partnership

Frank Chen (fc2451) and Ryan Quan (rcq2102) will be collaborators on this project.

## Research Question

This project will focus on building a prediction model for the onset of sepsis in the ICU using clinical history and physiological data obtained in the first two hours of admission. This allows one to better detect the need for prophylactic intervention within a critically ill patient population. 

Generalizability of the model would only go as far as the confines of the MIMIC II Clinical Database, from the assumption that prediction power is only applicable within the same practice in which the EMR data was collected.

## Background

Sepsis is systemic inflammatory response syndrome (SIRS), secondary to a documented infection. Sepsis can present itself on a continuum that ranges from sepsis, severe sepsis, and septic shock, resulting in multiple organ dysfunction. The symptoms of sepsis are often non-specific, and involve difficulty breathing, hypoxemia, hypoperfusion, and hypotension. 

Although sepsis is a common condition worldwide, the current understanding of the pathophysiology of sepsis has increased substantially, and sepsis mortality has declined in the last two decades. The reason for the decline may be attributed to improved supportive care and the inherent symptomatology of patients who fall prey to sepsis. On the contrary, epidemiologic data suggests that sepsis incidence is increasing. New treatments and therapies have failed to demonstrate efficacy. Sepsis affects approximately 700,000 people per year, and accounts for approximately 200,000 deaths per year in the United States, amassing an annual cost of 16.7 billion dollars.

The best form of treatment is preventative treatment, which is most often the case when it comes to life-threatening conditions. Early diagnosis and appropriate therapy must be given before certain laboratory tests are known, which bases the diagnosis on particular symptoms that occur together. [Insert need for better prediction?]()

Patients included in the prediction model will consist of subjects who have acquired sepsis during their ICU stay. To avoid bias introduced by censorship, we will exclude samples who have not been in the ICU for longer than 2 hours, as patients will not have accrued enough data to make a risk assessment.  

To avoid bias introduced by confounding medical interventions, patients with
previously identified microbiology events and prescribed prophylactic treatment within the first 2 hours will also be excluded.

The Surviving Sepsis Campaign defines prophylactic treatment as "immediate intervention with pressors, antibiotics, and fluid resuscitation."

Identified risk factors for sepsis include:

* management of respiratory distress (ICD-9 code 786.09)
* hypoxemia (ICD-9 code 799.02)
* hypotension (ICD-9 codes 458 796.3)
* hypoperfusion (ICD-9 code 785.50)
* tachycardia
* elevated serum lactate (organ hypoperfusion)
* fever, chills
* mental function is altered
* hyperventilation with respiratory alkolosis
* balance of pro-inflammatory and anti-inflammatory mediators
* effects of microorganisms (*Staphylococcus, Escherichia coli, Staphylococcus aureus, Klebsiella pneumoniae, Enterobacter sp, Acinetobacter baumannii, Pseudomonas aeruginosa, and Candida sp*)

## Description of Dataset

The data will be from the Multiparameter Intelligent Monitoring in Intensive Care Database (MIMIC II), which presents ICU patient records for approximately 25,000 adults at Boston's Beth Israel Deaconess Medical Center.

**Number of Sepsis-related Cases by ICD-9 Code**

```sql
SELECT code, count(*) AS count 
    FROM mimic2v26.ICD9 
    WHERE code LIKE '995.9%'
    OR code = '785.52'
    GROUP BY code 
```

**Number of Unique Subjects with Sepsis-related Complications**

```sql
SELECT count(DISTINCT subject_id) AS sample_size
    FROM mimic2v26.ICD9 
    WHERE code LIKE '995.9%'
    OR code = '785.52'
```

## Methods

### Feature Selection

Process for feature selection has not yet been decided. However, since our model is intended to predict onset of sepsis, we will restrict features to vitals collected within a specified time frame of admission to the ICU.





### Analysis

As this is a supervised classification problem that requires some clinical interpretability, we have elected to use the following models to predict the onset of sepsis within the ICU:

* Logistic Regression
* Naive Bayes
* Decision Trees

We have taken note of pre-existing scoring systems, which we will use as benchmarks for comparison. For example, the SIRS criteria uses four simple rules to flag patients at risk for sepsis-related complications. In order for our prediction model to be useful in the clinical setting, we must at least achieve greater predictive accuracy than the SIRS criteria.

Moreover, since our goal is to detect early onset of sepsis, we ideally want our model to have high accuracy with data collected within the first 24 hours. As such, we may elect to compare models trained on data collected at varying time intervals, e.g. 3 hours, 6 hours, and 12 hours after ICU admission.

## Tools

We will be using the `glm`, `e1071`, `rpart`, and `caret` packages from CRAN for model training, testing, and validation. We may elect to validate using the `sklearn` library in Python.

Data for the analysis will be pulled from either the flat-files via a Python script or a virtual machine preloaded with a PostgreSQL database - both of which are available on PhysioNet. 

## Potential Features

http://www.uptodate.com/contents/evaluation-and-management-of-severe-sepsis-and-septic-shock-in-adults

http://library.ahima.org/xpedio/groups/public/documents/ahima/bok1_033812.hcsp?dDocName=bok1_033812



http://www.uptodate.com/contents/pathophysiology-of-sepsis?source=see_link






movement around hospital
blood pressure
immunocompromised