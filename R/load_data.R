devtools::add_path('/Applications/Postgres.app/Contents/Versions/9.4/bin/')
devtools::install("~/Downloads/rpostgresql-read-only/RPostgreSQL/")

library(plyr)
library(dplyr)
library(reshape2)
library(magrittr)
db <- src_postgres(dbname = "MIMIC2",
				   host = "ec2-54-163-173-71.compute-1.amazonaws.com",
				   port = 5432,
				   user = "ec2-user",

# Picking Cases and Controls
# Filtering for First Day ICU Only

query <- sql(
	"SELECT subject_id, hadm_id, icustay_id
FROM mimic2v26.icustay_detail
WHERE (icustay_first_flg = 'Y' AND subject_icustay_seq = '1' AND icustay_age_group = 'adult')
AND subject_id IN
    (SELECT DISTINCT subject_id
    FROM mimic2v26.icd9
    WHERE (code LIKE '995.9%' OR code = '785.52'))"
)

caseID <- tbl(db, query) %>%
	collect()

query <- sql(
	"SELECT subject_id, hadm_id, icustay_id
FROM mimic2v26.icustay_detail
WHERE (icustay_first_flg = 'Y' AND subject_icustay_seq = '1' AND icustay_age_group = 'adult')"
)

controlID <- tbl(db, query) %>%
	filter(!(subject_id %in% caseID$subject_id)) %>%
	collect()

set.seed(1)
randomSubset <- sample(controlID$subject_id, 5000)
controls <- controlID[controlID$subject_id %in% randomSubset, ]
ids <- rbind(caseID, controls)

#####################################################################

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
"SELECT subject_id, icustay_id, itemid, charttime, value1num 
FROM mimic2v26.chartevents 
WHERE itemid IN (615, 646, 6, 51, 455, 6701, 211, 50316, 50468, 20002, 920, 3580) 
ORDER BY subject_id"
)

df <- tbl(db, query) %>% 
	filter(subject_id %in% ids$subject_id & icustay_id %in% ids$icustay_id) %>%
	mutate(timeString=as.character(charttime)) %>% 
	select(-charttime) %>% 
	collect()

df %<>% mutate(charttime=as.POSIXct(timeString))

## Load Chart Data ------------------------------

# ground <- df %>% 
# 	group_by(subject_id, icustay_id, itemid) %>%
# 	mutate(min = min(charttime))

df2 <- df %>%
	group_by(subject_id, icustay_id, itemid) %>%	
	mutate(groundTime=min(charttime),
		   intHour=as.numeric(difftime(charttime, groundTime, tz="EST", units="hours")), 
		   intHourR=round(intHour))

df2 %<>% group_by(subject_id, icustay_id, itemid, intHourR) %>% 
	summarize(mean=mean(value1num), 
			  sd=sd(value1num))

df3 <- df2 %>%
	ungroup() %>%
	filter(intHourR <= 24 & intHourR >= 0) %>%
	select(subject_id, itemid, intHourR, mean) %>%
	melt(id.vars=c("subject_id", "itemid", "intHourR")) %>%
	dcast(subject_id ~ itemid + intHourR + variable, value.var="value")
