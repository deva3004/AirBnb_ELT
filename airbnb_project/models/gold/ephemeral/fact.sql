{{
    config(materialized='table')
}}

{% set table_config =[
    {
        "table": ref('obt'),
        "columns" : "GOLD_obt.BOOKING_ID, GOLD_obt.LISTING_ID, GOLD_obt.HOST_ID, GOLD_obt.TOTAL_AMOUNT, GOLD_obt.ACCOMMODATES, GOLD_obt.BEDROOMS, GOLD_obt.PRICE_PER_NIGHT_TAG, GOLD_obt.RESPONSE_RATE",
        "alias": "GOLD_obt"
    },
    {
        "table": ref('silver_listings'),
        "columns" : "",
        "alias": "DIM_LISTING",
        "join_condition": "GOLD_obt.LISTING_ID = DIM_LISTING.LISTING_ID"
    },
    {
        "table": ref('silver_host'),
        "columns" : "",
        "alias": "DIM_HOSTS",
        "join_condition": "GOLD_obt.HOST_ID = DIM_HOSTS.HOST_ID"
    }
]%}

SELECT
    {{ table_config[0]['columns'] }}
FROM
{% for table_config_item in table_config %}
{% if loop.first %}
    {{ table_config_item['table'] }} AS {{ table_config_item['alias'] }}
{% else %}
    JOIN {{ table_config_item['table'] }} AS {{ table_config_item['alias'] }}
    ON {{ table_config_item['join_condition'] }}
{% endif %}
{% endfor %}
