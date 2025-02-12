WITH temp_join_margin_ship AS (
SELECT *
FROM {{ ref('int_orders_margin') }} as margin
LEFT JOIN {{ ref('stg_gz_raw_data__raw_gz_ship') }} as ship
USING (orders_id)
)

SELECT 
    orders_id
    ,date_date
    ,ROUND((margin + shipping_fee - logcost - ship_cost),2) AS Operational_margin 
    ,revenue
    ,quantity
    ,purchase_cost
    ,margin
    ,shipping_fee
    ,ship_cost
    ,logcost
FROM temp_join_margin_ship
