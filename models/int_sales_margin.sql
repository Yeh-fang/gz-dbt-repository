With temp_join_order_product AS (
SELECT 
    sales.date_date
    ,sales.orders_id
    ,sales.pdt_id AS products_id
    ,sales.revenue
    ,sales.quantity
    ,product.purchase_price
FROM {{ ref('stg_gz_raw_data__raw_gz_sales') }} AS sales
LEFT JOIN {{ ref('stg_gz_raw_data__raw_gz_product') }} AS product
ON sales.pdt_id = product.products_id
)

SELECT 
    *
    ,ROUND(quantity*purchase_price,2) AS purchase_cost
    ,ROUND((revenue - (quantity*purchase_price)),2) AS margin
FROM temp_join_order_product