devtools::add_path('/Applications/Postgres.app/Contents/Versions/9.4/bin/')
devtools::install("~/Downloads/rpostgresql-read-only/RPostgreSQL/")

library(dplyr)
db <- src_postgres(dbname = "MIMIC2",
                  host = "ec2-54-163-173-71.compute-1.amazonaws.com",
                  port = 5432,
                  user = "ec2-user",
                  password = "thisisalongpassword1234")

query <- sql(
"SELECT subject_id
FROM mimic2v26.d_patients
WHERE subject_id NOT IN
    (SELECT subject_id
        FROM mimic2v26.icd9
        WHERE code LIKE '995.9%' or code = '785.52')
ORDER BY random() LIMIT 5000"
)

query <- sql(
"SELECT subject_id
FROM mimic2v26.icd9
WHERE code LIKE '995.9%' OR code = '785.52'"
)

query <- sql(
"SELECT * 
FROM mimic2v26.chartevents 
WHERE itemid in (615, 646, 6, 51, 455, 6701, 211, 50316, 50468, 20002, 920, 3580) 
ORDER BY subject_id
LIMIT 500"
)

df <- tbl(db, query) %>% group_by(subject_id, icustay_id) %>% 
	select(subject_id, icustay_id, itemid, charttime, value1num) %>% 
	filter(subject_id %in% caseID$subject_id) %>% collect()
ground <- df %>% filter(row_number()==1)
df %<>% mutate(intHour=as.numeric(difftime(charttime, ground$charttime[subject_id], 
												  tz="EST", units="hours")),
					  intHourR=round(intHour))
df %<>% group_by(subject_id, icustay_id, itemid, intHourR) %>% summarize(value1Mean=mean(value1num),
																		  value1Sd=sd(value1num))


