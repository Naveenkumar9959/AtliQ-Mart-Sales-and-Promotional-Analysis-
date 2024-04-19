/* Generate a report that displays each campaign along with the total revenue generated before and after the campaign? 
The report includes three key fields: campaign_name, total_revenue (before_promotion), 
total_revenue(after_promotion). This report should help in evaluating the financial impact of our promotional campaigns. 
(Display the values in millions)
*/


with new_fe as (SELECT *
        ,CASE
            WHEN
                ((promo_type = '50% OFF')
                    OR (promo_type = 'BOGOF'))
            THEN
                (base_price * 0.50)
            WHEN (promo_type = '25% OFF') THEN (base_price - (base_price * 0.25))
            WHEN (promo_type = '500 Cashback') THEN (base_price- 500)
            WHEN (promo_type = '33% OFF') THEN (base_price - (base_price * 0.33))
        END AS `base_price_after_promo`
    FROM
        fact_events)


SELECT 
    campaign_name,
    SUM(base_price * `quantity_sold(before_promo)`) / 1000000 AS "total_Revenue_before_promotion (M)",
    SUM(base_price_after_promo * `quantity_sold(after_promo)`) / 1000000 as "total_Revenue_after_promotion (M)" 
FROM
    new_fe AS fe
        INNER JOIN
    dim_campaigns AS dm ON fe.campaign_id = dm.campaign_id
GROUP BY dm.campaign_name;