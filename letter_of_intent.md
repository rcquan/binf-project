---
title: Project Letter of Intent
author: Ryan Quan, Frank Chen
date: 2015-02-23
---

## Declaration of Partnership

Frank Chen (fc2451) and Ryan Quan (rcq2102) will be collaborators on this project.

## Research Question

This project will focus on building a prediction model for the onset of septic shock in the ICU, allowing one to better detect the need for prophylactic intervention within a critically ill patient population. 

Generalizability of the model would only go as far as the confines of the MIMIC II Clinical Database, from the assumption that prediction power is only applicable within the same practice in which the EMR data was collected.

## Description of Dataset

The data will be from the Multiparameter Intelligent Monitoring in Intensive Care Database (MIMIC II), which presents ICU patient records for approximately 25,000 adults at Boston's Beth Israel Deaconess Medical Center.

Patients included in the prediction model include those who have acquired septicemia during their ICU stay. To avoid bias introduced by censorship, we will exclude samples who have not been in the ICU for longer than x hours, as patients will not have accrued enough data to make a risk assessment.  

To avoid bias introduced by confounding medical interventions, patients with
previously identified microbiology events and prescribed prophylactic treatment will also be excluded.

The Surviving Sepsis Campaign defines prophylactic treatment as "immediate intervention with pressors, antibiotics, and fluid resuscitation."

## Methods

SELECT * FROM mimic2v26.ICD9
WHERE code LIKE '29%' 
    OR code LIKE '30%' 
    OR code LIKE '31%'

## Tools

R, SQL, Python?