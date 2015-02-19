---
title: Project Letter of Intent
author: Ryan Quan, Frank Chen
date: 2015-02-23
---

## Declaration of Partnership

Frank Chen (fc2451) and Ryan Quan (rcq2102) will be collaborators on this project.

## Research Question

* predicting onset of septic shock in the ICU
* eliminate 

## Other

* predicting mental disorders in (type) patients readmitted to the ICU

* multiple admissions, were patients readmitted for a condition that was not existent in the first time?

* prediction of outcome
* populations at risk
* readmission rate
* demographics

* gut pathogenic ICD-9 codes, predict worse or better outcomes

* average ICD-9 codes for a specific population that predicts survival (eliminate trauma)

* predicting ideal candidate who gets out or lands in the ICU
* predicting survival of brain injured patients via some marker

## Description of Dataset

## Methods

SELECT * FROM mimic2v26.ICD9
WHERE code LIKE '29%' 
    OR code LIKE '30%' 
    OR code LIKE '31%'

## Tools