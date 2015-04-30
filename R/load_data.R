# devtools::add_path('~/usr/local/bin/psql')
# devtools::install("~/Downloads/rpostgresql-read-only/RPostgreSQL/")
library(dplyr)
db <- src_postgres(dbname = "MIMIC2",
                  host = "ec2-52-11-227-94.us-west-2.compute.amazonaws.com",
                  port = 5432,
                  user = "ec2-user",
                  password = "mimic1234")

qControlID <- sql(
"SELECT subject_id
FROM mimic2v26.d_patients
WHERE subject_id NOT IN
    (SELECT subject_id
        FROM mimic2v26.icd9
        WHERE code LIKE '995.9%' or code = '785.52')
ORDER BY random() LIMIT 5000"
)

qCaseID <- sql(
"SELECT subject_id
FROM mimic2v26.icd9
WHERE code LIKE '995.9%' OR code = '785.52'"
)

controlID <- tbl(db, qControlID)
collect(controlID)
