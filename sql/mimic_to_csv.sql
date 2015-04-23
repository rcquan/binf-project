-- get subject_ids of patients with sepsis
create table sepsis_ids as
select subject_id
from mimic2v26.icd9
where code like '995.9%' or code = '785.52';

-- get subject_ids of random patients without sepsis
insert into sepsis_ids
select subject_id
from mimic2v26.d_patients
where subject_id not in (
    select subject_id
    from mimic2v26.icd9
    where code like '995.9%' or code = '785.52')
order by random()
limit 5000;

-- export sepsis_ids to csv
\copy (select *
    from mimic2v26.icd9
    where code like '995.9%' or code = '785.52')
to '~/Downloads/sepsis_ids.csv' with csv header;

-- export nonsepsis_ids to csv
\copy (select subject_id
from mimic2v26.d_patients
where subject_id not in (
    select subject_id
    from mimic2v26.icd9
    where code like '995.9%' or code = '785.52')
order by random()
limit 10000)
to '~/Downloads/nonsepsis_ids.csv'
with csv header;

-- export chart values of cohort
\copy (select * from mimic2v26.chartevents where itemid in (615, 646, 6, 51, 455, 6701, 211, 50316, 50468, 20002, 920, 3580) and subject_id in (select subject_id from sepsis_ids)) to '~/Downloads/sepsis_chart_values.csv' with csv header;
-- export demographic values of cohort
\copy (select * from mimic2v26.demographicevents as a join mimic2v26.d_demographicitems as b on (a.itemid=b.itemid) where subject_id in (select subject_id from sepsis_ids)) to '~/Downloads/sepsis_demographics.csv' with csv header;