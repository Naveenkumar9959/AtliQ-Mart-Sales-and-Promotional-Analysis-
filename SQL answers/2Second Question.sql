-- 2nd question 
/*
Generate a report that provides an overview of the number of stores in each city. 
The results will be sorted in descending order of store counts, 
allowing us to identify the cities with the highest store presence. 
The report includes two essential fields: city and store count, which will assist in optimizing our retail operations.
*/

SELECT 
    city, COUNT(*) AS no_of_stores_in_each_city
FROM
    dim_stores
GROUP BY city
ORDER BY no_of_stores_in_each_city DESC;