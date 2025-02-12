{% macro margin_percent(revenue, purchase_cost, precision) %}
    ROUND((SAFE_DIVIDE(({{revenue}} - {{purchase_cost}}) , {{revenue}} )*100), {{precision}}) AS margin_percent
{% endmacro %}
