---------------------------- HOMEWORK #4 ------------------------------------------
select *
from fact_table
;
-- Created one duplicate of 'Rifampicin' --
INSERT INTO antibiotic_table (Antibiotic_name)
VALUES ('Rifampicin')
;
-- Finded duplicates in antibiotics --
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
-- I want to select antibiotic and organism based on gene mutation. Every time I see the gene_id NULLIF it will replace to mutation (helping me to remode nullif - only useful).
select
ANTIBIOTIC_name,
ORGANISM_name,
NULLIF (Gene_name, 'Mutation') AS Gene
from
fact_table
;
-- COALESCE. I want to know typeas of antibiotic and organism based on gene mutation (in differenct way). (find the ANSWER)
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
                                           









 

