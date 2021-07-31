create database bi_marathon_olga;
use bi_marathon_olga;
-- Creating a temp table to load our CSV file
create table temp_table
(
	DRUG_NAME varchar(100)
	,ORGANISM_NAME varchar (100)
 	,GENE_NAME varchar (100)
	,SAMPLE_LOCATION varchar (100)
)
;
-- select all rows from tem_table
SELECT * FROM bi_marathon_olga.temp_table
;
-- create #1 dimention DRUG_NAME_table
create table DRUG_NAME_table(
	  DRUG_NAME int not null auto_increment
    ,DRUG_NAME_name varchar(255)
    , primary key (DRUG_NAME)
    )
    ;
-- create #2 dimention ORGANISM_NAME_table
create table ORGANISM_NAME_table(
	ORGANISM_NAME int not null auto_increment
    ,ORGANISM_NAME_name varchar(255)
    , primary key (ORGANISM_NAME)
    )
    ;
    -- create #3 dimention GENE_NAME_table(
create table GENE_NAME_table(
	GENE_NAME int not null auto_increment
    ,GENE_NAME_name varchar (255)
    , primary key (GENE_NAME)
    )
    ;
-- create #4 dimention SAMPLE_LOCATION_table(
create table SAMPLE_LOCATION_table(
	SAMPLE_LOCATION int not null auto_increment
    ,SAMPLE_LOCATION_name varchar (255)
    , primary key (SAMPLE_LOCATION)
    )
    ;
    -- creat fact_table
    create table fact_table 
    (  
    fact_id int not null auto_increment
    ,DRUG_NAME_id int
    ,ORGANISM_NAME_id int
    ,GENE_NAME_id int
    ,SAMPLE_LOCATION_id int
    ,primary key(fact_id)
    ,FOREIGN KEY (DRUG_NAME_id) REFERENCES DRUG_NAME_table (DRUG_NAME) ON DELETE SET NULL
    ,FOREIGN KEY (ORGANISM_NAME_id) REFERENCES ORGANISM_NAME_table (ORGANISM_NAME) ON DELETE SET NULL
    ,FOREIGN KEY (GENE_NAME_id) REFERENCES GENE_NAME_table (GENE_NAME) ON DELETE SET NULL
    ,FOREIGN KEY (SAMPLE_LOCATION_id) REFERENCES SAMPLE_LOCATION_table (SAMPLE_LOCATION) ON DELETE SET NULL 
    )
    ;
    drop table fact_table
-- uploading drug_name_table
INSERT IGNORE INTO DRUG_NAME_table (DRUG_NAME_name)
SELECT DISTINCT DRUG_NAME FROM temp_table
;
select *
from drug_name_table;
-- uploading organism_name_table
INSERT IGNORE INTO ORGANISM_NAME_table (ORGANISM_NAME_name)
SELECT DISTINCT ORGANISM_NAME FROM temp_table
;
select *
from ORGANISM_NAME_table;
-- uploading gene_name_table
INSERT IGNORE INTO GENE_NAME_table (GENE_NAME_name)
SELECT DISTINCT GENE_NAME FROM temp_table
;
select *
from GENE_NAME_table;
-- uploading sample_location_table
INSERT IGNORE INTO SAMPLE_LOCATION_table (SAMPLE_LOCATION_name)
SELECT DISTINCT SAMPLE_LOCATION FROM temp_table
;
select *
from SAMPLE_LOCATION_table;
;
-- uploading fact table
INSERT IGNORE INTO fact_table(DRUG_NAME_id,ORGANISM_NAME_id,GENE_NAME_id,SAMPLE_LOCATION_id)
SELECT distinct
    d.DRUG_NAME_id
    ,o.ORGANISM_NAME_id
    ,g.GENE_NAME_id
    ,s.SAMPLE_LOCATION_id
FROM temp_table t
JOIN DRUG_NAME_table d ON d.DRUG_NAME_name = t.DRUG_NAME
JOIN ORGANISM_NAME_table o ON o.ORGANISM_name = t.ORGANISM_NAME
JOIN GENE_NAME_table g ON g.GENE_NAME_name = t.GENE_NAME
JOIN SAMPLE_LOCATION_table s ON s.SAMPLE_LOCATION_name = t.SAMPLE_LOCATION
;
---------------------------- HOMEWORK #4 ------------------------------------------
;
select *
from fact_table
;
INSERT INTO antibiotic_table (Antibiotic_name)
VALUES ('Rifampicin')
;
Select antibiotic_name
,COUNT(*) as CNT
From antibiotic_table
Group by antibiotic_name
having count(*)>1
;
Select gene_name
,COUNT(*) as CNT
From gene_table
Group by gene_name
having count(*)>1
;
Select location_name
,COUNT(*) as CNT
From location_table
Group by location_name
having count(*)>1
;
Select organism_name
,COUNT(*) as CNT
From organism_table
Group by ORGANISM_name
having count(*)>1
;
WITH cte AS
(SELECT antibiotic_id
,antibiotic_name
,ROW_NUMBER() OVER (
PARTITION BY
antibiotic_name
ORDER BY
antibiotic_name
)  as row_num
FROM antibiotic_table)
SELECT *
FROM cte
WHERE row_num >1
;
select
ANTIBIOTIC,
ORGANISM,
NULLIF (Gene, 'Mutation') AS Gene
from
temp_table
;
select
ANTIBIOTIC,
ORGANISM,
coalesce(Gene, 'NO NAME') AS Gene
from
temp_table
;
select
fact_id
ANTIBIOTIC_ID,
ORGANISM_ID,
LOCATION_ID,
GREATEST (15, GENE_ID) AS GENE_ID
FROM
fact_table
;
-- this is not working and I do not understand why =(
SELECT 
distinct Antibiotic_name
FROM antibiotic_table
;
-- this is not working and I do not understand why =(
;
