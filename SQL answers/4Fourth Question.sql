/*
4.Produce a report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign. 
Additionally, provide rankings for the categories based on their ISU%. 
The report will include three key fields: category, isu%, and rank order. 
This information will assist in assessing the category-wise success and impact of the Diwali campaign on incremental sales.
Note: ISU% (Incremental Sold Quantity Percentage) is calculated as the percentage increase/decrease in quantity sold (after promo) compared to quantity sold (before promo)
*/

with sales as (SELECT 
    category,
    round((SUM(`quantity_sold(after_promo)`) - SUM(`quantity_sold(before_promo)`)) / (SUM(`quantity_sold(before_promo)`)) * 100 , 2) AS 'ISU%'
FROM
    fact_events AS fe
        INNER JOIN
    dim_products AS dp ON fe.product_code = dp.product_code
    where campaign_id= "CAMP_DIW_01"
GROUP BY category)

select *, dense_rank() over(order by `ISU%` desc)  as rank_of_ISU from sales;