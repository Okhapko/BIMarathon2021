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
select *
from fact_table
;
-- I create duplicate of 'Rifampicin' --
INSERT INTO antibiotic_table (Antibiotic_name)
VALUES ('Rifampicin')
;
-- I want to find duplicates in antibiotics --
Select antibiotic_name
,COUNT(*) as CNT
From antibiotic_table
Group by antibiotic_name
having count(*)>1
;
-- I want to find duplicates in antibiotics (in different way) --
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
-- I want to secelt antibiotic and organism based on gene mutation. 
select
ANTIBIOTIC_id,
ORGANISM_id,
NULLIF (Gene_id, 'Mutation') AS Gene
from
fact_table
;
-- COALESCE. I want to know typeas of antibiotic and organism based on gene mutation (in differenct way).
select
ANTIBIOTIC_id,
ORGANISM_id,
coalesce(Gene_id, 'NO NAME') AS Gene_id
from fact_table
;
-- LEAST/GREATEST. I want to know what type of antibiotic is most common? It is Rifampicin.
select
ANTIBIOTIC_id,
GREATEST (1,Antibiotic_id) AS ANTIBIOTIC_name
FROM fact_table
;
-- DISTINCT. I want to know my unique values. In this case it is group of antibiotics.
SELECT 
distinct Antibiotic_name
FROM antibiotic_table
;
                                            -- Homework #5 --
select *
from fact_table
;
-- a) Common Table Expretion (CTEs) -- find how many and what kind of different mutations in antibiotic Rifampicin.
WITH CTE_1 as(
select distinct antibiotic_id
from antibiotic_table
Where antibiotic_name in ("Rifampicin")
)
,CTE_2 as (
select distinct Gene_id
from gene_table
)
select antibiotic_id
, gene_id
from fact_table
Where antibiotic_id in (select distinct antibiotic_id from CTE_1)
and Gene_id in (select distinct Gene_id from CTE_2)
;
-- Recursive CTEs -- I want to find location hierarchy --Do not make sense to my database
;
-- Pivoting Data w/ Case when -- I want to connect all rowl in my data base -- Do not make sense to my database -- (question: if I want to connect only one type of organism, what I need to rigth?)
;
-- Self joins -- I wan to see organism to the location (origin) do not work =(
select
a.Name as Location_table
from 
Location_table as a
Join Location_table as b on a.location_table = b.organism_table
Where a.location_table > b.organism_table
;
-- window functions -- I want to see location in alphabetic order -- Do not make sense to my database
;
-- Calculating Running Totals -- Do not make sense to my database --
;
-- Calculating Delta Values -- Do not make sense to my database --
;
-- Except vs NOT IN -- I want to see only organism, antibiotic, and location -- Not working =(
Select fact_table
,fact_id
,antibiotic_id
,organism_id
,location_id 
From fact_table
Except 
select gene_id
from fact_table
;
-- Date time manipulation -- Do not make sense to my database
;





 











 

