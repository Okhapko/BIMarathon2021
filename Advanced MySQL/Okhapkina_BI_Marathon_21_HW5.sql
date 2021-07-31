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
