SELECT
 orders_id
 ,date_date
 ,ROUND(sum(revenue),2) as revenue
 ,ROUND(sum(quantity),2) as quantity
 ,ROUND(sum(purchase_cost),2) as purchase_cost
 ,ROUND(sum(margin),2) as margin
FROM {{ ref('int_sales_margin') }}
GROUP BY orders_id,date_date