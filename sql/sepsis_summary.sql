-- MIMIC II SQL Queries for Sepsis Prediction Project
-- Ryan Quan and Frank Chen


-- Number of Sepsis-related Cases by ICD-9 Code
SELECT code, count(*) AS count
    FROM mimic2v26.ICD9
    WHERE code LIKE '995.9%'
    OR code = '785.52'
    GROUP BY code


-- Number of Unique Subjects with Sepsis-related Complications
SELECT count(DISTINCT subject_id) AS sample_size
    FROM mimic2v26.ICD9
    WHERE code LIKE '995.9%'
    OR code = '785.52'