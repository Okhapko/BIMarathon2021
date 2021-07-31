create database bi_marathon_olga_second;
use bi_marathon_olga_second;
-- uploading exel_file (create temp_table)
create table temp_table
(
	ANTIBIOTIC varchar(100)
	,ORGANISM varchar (100)
 	,GENE varchar (100)
	,LOCATION varchar (100)
)
;
-- select all rows from tem_table
SELECT * FROM bi_marathon_olga_second.temp_table
;
truncate temp_table
;
-- create #1 dimention ANTIBIOTIC_table
create table ANTIBIOTIC_table(
	  ANTIBIOTIC_id int not null auto_increment
    ,ANTIBIOTIC_name varchar(255)
    , primary key (ANTIBIOTIC)
    )
    ;
    drop table ANTIBIOTIC_table
    ;
-- create #2 dimention ORGANISM_table
create table ORGANISM_table(
	ORGANISM_id int not null auto_increment
    ,ORGANISM_name varchar(255)
    , primary key (ORGANISM)
    )
    ;
        drop table ORGANISM_table
    ;
    -- create #3 dimention GENE_table(
create table GENE_table(
	GENE_id int not null auto_increment
    ,GENE_name varchar (255)
    , primary key (GENE_id)
    )
    ;
    drop table Gene_table
    ;
-- create #4 dimention LOCATION_table(
create table LOCATION_table(
	LOCATION_id int not null auto_increment
    ,LOCATION_name varchar (255)
    , primary key (LOCATION_id)
    )
    ;
-- create #1 dimention ANTIBIOTIC_table
create table ANTIBIOTIC_table(
	  ANTIBIOTIC_id int not null auto_increment
    ,ANTIBIOTIC_name varchar(255)
    , primary key (ANTIBIOTIC_id)
    )
    ;
    -- create #2 dimention ORGANISM_table
    create table ORGANISM_table(
	ORGANISM_id int not null auto_increment
    ,ORGANISM_name varchar(255)
    , primary key (ORGANISM_id)
    )
    ;
	-- create #3 dimention GENE_table(
create table GENE_table(
	GENE_id int not null auto_increment
    ,GENE_name varchar (255)
    , primary key (GENE_id)
    )
    ;
    -- creat fact_table
    create table fact_table 
    (  
    fact_id int not null auto_increment
    ,ANTIBIOTIC_id int
    ,ORGANISM_id int
    ,GENE_id int
    ,LOCATION_id int
    ,primary key(fact_id)
    ,FOREIGN KEY (ANTIBIOTIC_id) REFERENCES ANTIBIOTIC_table (ANTIBIOTIC_id) ON DELETE SET NULL
    ,FOREIGN KEY (ORGANISM_id) REFERENCES ORGANISM_table (ORGANISM_id) ON DELETE SET NULL
    ,FOREIGN KEY (GENE_id) REFERENCES GENE_table (GENE_id) ON DELETE SET NULL
    ,FOREIGN KEY (LOCATION_id) REFERENCES LOCATION_table (LOCATION_id) ON DELETE SET NULL 
    )
    ;
    -- uploading ANTIBIOTIC_table
INSERT IGNORE INTO ANTIBIOTIC_table (ANTIBIOTIC_name)
SELECT DISTINCT ANTIBIOTIC FROM temp_table
;
select *
from ANTIBIOTIC_table;
;
-- uploading ORGANISM_table
INSERT IGNORE INTO ORGANISM_table (ORGANISM_name)
SELECT DISTINCT ORGANISM FROM temp_table
;
select *
from ORGANISM_table;
;
-- uploading GENE_table
INSERT IGNORE INTO GENE_table (GENE_name)
SELECT DISTINCT GENE FROM temp_table
;
select *
from GENE_table;
;
-- uploading LOCATION_table
INSERT IGNORE INTO LOCATION_table (LOCATION_name)
SELECT DISTINCT LOCATION FROM temp_table
;
select *
from LOCATION_table;
;
-- uploading fact table
INSERT IGNORE INTO fact_table(ANTIBIOTIC_id,ORGANISM_id,GENE_id,LOCATION_id)
SELECT distinct
    a.ANTIBIOTIC_id
    ,o.ORGANISM_id
    ,g.GENE_id
    ,l.LOCATION_id
FROM temp_table t
JOIN ANTIBIOTIC_table a ON a.ANTIBIOTIC_name = t.ANTIBIOTIC
JOIN ORGANISM_table o ON o.ORGANISM_name = t.ORGANISM
JOIN GENE_table g ON g.GENE_name = t.GENE
JOIN LOCATION_table l ON l.LOCATION_name = t.LOCATION
;
select *
from fact_table
    
    