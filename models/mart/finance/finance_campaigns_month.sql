WITH month_finance_sum AS(
SELECT 
    DATE_TRUNC(date_date, MONTH) AS date_month
    ,SUM(nb_transactions) AS nb_transactions
    ,SUM(revenue) AS revenue
    ,ROUND(SUM(average_basket),2) AS average_basket
    ,ROUND(SUM(average_basket_bis),2) AS average_basket_bis
    ,ROUND(SUM(margin),2) AS margin
    ,ROUND(SUM(operational_margin),2) AS operational_margin
    ,ROUND(SUM(purchase_cost),2) AS purchase_cost
    ,ROUND(SUM(shipping_fee),2) AS shipping_fee
    ,SUM(logcost) AS logcost
    ,SUM(ship_cost) AS ship_cost
    ,SUM(quantity) AS quantity
FROM {{ ref('finance_days') }}
GROUP BY DATE_TRUNC(date_date, MONTH) 
)

, temp_ads AS (
SELECT 
    DATE_TRUNC(date_date, MONTH) AS date_month
    ,ROUND(SUM(ads_cost),2) AS ads_cost
    ,ROUND(SUM(ads_impression),2) AS ads_impression
    ,ROUND(SUM(ads_clicks),2) AS ads_clicks
FROM {{ ref('int_campaigns_day') }}
GROUP BY DATE_TRUNC(date_date, MONTH)
)

SELECT 
    fi.date_month
    ,(fi.operational_margin - ad.ads_cost) AS ads_margin
    ,fi.average_basket
    ,fi.operational_margin
    ,ad.ads_cost
    ,ad.ads_impression
    ,ad.ads_clicks
    ,fi.quantity
    ,fi.revenue
    ,fi.purchase_cost
    ,fi.margin
    ,fi.shipping_fee
    ,fi.logcost
    ,fi.ship_cost
FROM month_finance_sum AS fi
LEFT JOIN temp_ads AS ad
USING (date_month)
ORDER BY date_month DESC