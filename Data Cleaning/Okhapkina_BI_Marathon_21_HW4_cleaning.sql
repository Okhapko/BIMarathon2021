														-- Start -- 
select *
from fact_table
;
-- Create one duplicate of 'Rifampicin' --
INSERT INTO antibiotic_table (Antibiotic_name)
VALUES ('Rifampicin')
;
-- Finded duplicates in antibiotics --
Select antibiotic_name
,COUNT(*) as CNT -- COMENT: COUNT (*) also counts NULL values and duplicates. It counts each row separately --
From antibiotic_table
Group by antibiotic_name -- COMENT: Group by select statement partitions result rows into groups, based on their values in one or several columns. In this case it sort by 'antibiotic_mane'.
having count(*)>1 -- COMENT: having count(*)>1 find duplicates in antibiotic_name more than 1 time. In this case it is 'Rifampicin'.
;
-- Using CTE approach--
WITH cte AS
(SELECT antibiotic_id
,antibiotic_name
,ROW_NUMBER() OVER ( -- Coment: Row_number() over( calculate an aggregate value based on a group -- 
PARTITION BY -- Coment: Partition by funticon analyse duplicates. In my case, it 7 dulticates --
antibiotic_name
ORDER BY -- Coment: Order by used to sort the result-set in ascending or descending order --
antibiotic_name
)  as duplicates
FROM antibiotic_table)
SELECT *
FROM cte
WHERE duplicates>1
;
-- creating null value -- 
select * 
from antibiotic_table
;
insert into antibiotic_table (antibiotic_name)
value (NULL)
;
select * 
from antibiotic_table
;
-- coalesce function. Coment: Coalesce function replace 'Null' value to a 'Placebo' value.
select ANTIBIOTIC_id
,coalesce (antibiotic_name,'Placebo') as antibiotic_name
from antibiotic_table
;
-- nullif function -- Coment: Nullif replace 'Placebo' on Null.
select ANTIBIOTIC_id
,nullif(antibiotic_name,'Placebo') as antibiotic_name
from antibiotic_table
;
                                                 -- Using differecnt functions-- 
-- GREATEST. Coment: GREATEST()function is used to find greatest values from given arguments respectively. In this case, it is #4
select 
gene_id,
GREATEST(1,2,3,4) AS Greatest_value 
FROM gene_table 
;
-- LEAST. Coment: LEAST()function is used to find lowest values from given arguments respectively. It is '1'
select 
Gene_id,
LEAST (1,2,3,4,5,6,7,8,9,10) as Lowest_value 
FROM Gene_table
;
-- DISTINCT. Coment: This function eliminates the repetitive appearance of the same data. 
SELECT 
distinct Location_name
FROM Location_table
;
															 -- END -- 