/*5.Create a report featuring the Top 5 products, 
ranked by Incremental Revenue Percentage (IR%), across all campaigns. 
The report will provide essential information including product name, category, and ir%. 
This analysis helps identify the most successful products in terms of incremental revenue across our campaigns, 
assisting in product optimization.
*/
with new_fe as (SELECT *
        ,CASE
            WHEN
                ((promo_type = '50% OFF')
                    OR (promo_type = 'BOGOF'))
            THEN
                (base_price * 0.50)
            WHEN (promo_type = '25% OFF') THEN (base_price - (base_price * 0.25))
            WHEN (promo_type = '500 Cashback') THEN (base_price - 500)
            WHEN (promo_type = '33% OFF') THEN (base_price - (base_price * 0.33))
        END AS `base_price_after_promo`
    FROM
       fact_events)

SELECT 
    product_name,
    category,
    ROUND(((SUM( base_price_after_promo * `quantity_sold(after_promo)`) - SUM(base_price * `quantity_sold(before_promo)`)) / SUM(base_price * `quantity_sold(before_promo)`)) * 100,
            2) AS `IR%`
FROM
    dim_products AS dp
        INNER JOIN
    new_fe AS fe ON dp.product_code = fe.product_code
GROUP BY product_name , category 
order by `IR%` desc
limit 5