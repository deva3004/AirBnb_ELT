{% set config =[
    {
        "table": ref('silver_bookings'),
        "columns" : "SILVER_BOOKING.BOOKING_ID, SILVER_BOOKING.LISTING_ID, SILVER_BOOKING.BOOKING_DATE, SILVER_BOOKING.TOTAL_AMOUNT, SILVER_BOOKING.BOOKING_STATUS, SILVER_BOOKING.CREATED_AT AS BOOKING_CREATED_AT",
        "alias": "SILVER_BOOKING"
    },
    {
        "table": ref('silver_listings'),
        "columns" : "SILVER_LISTING.HOST_ID,SILVER_LISTING.PROPERTY_TYPE, SILVER_LISTING.ROOM_TYPE,SILVER_LISTING.CITY, SILVER_LISTING.COUNTRY, SILVER_LISTING.ACCOMMODATES,SILVER_LISTING.BEDROOMS,SILVER_LISTING.BATHROOMS,SILVER_LISTING.PRICE_PER_NIGHT,SILVER_LISTING.PRICE_PER_NIGHT_TAG,SILVER_LISTING.CREATED_AT AS LISTING_CREATED_AT",
        "alias": "SILVER_LISTING",
        "join_condition": "SILVER_BOOKING.LISTING_ID = SILVER_LISTING.LISTING_ID"
    },
    {
        "table": ref('silver_host'),
        "columns" : "SILVER_HOSTS.HOST_NAME, SILVER_HOSTS.HOST_SINCE, SILVER_HOSTS.IS_SUPERHOST, SILVER_HOSTS.RESPONSE_RATE,SILVER_HOSTS.RESPONSE_RATE_QUALITY,SILVER_HOSTS.CREATED_AT AS HOST_CREATED_AT",
        "alias": "SILVER_HOSTS",
        "join_condition": "SILVER_LISTING.HOST_ID = SILVER_HOSTS.HOST_ID"
    }
]%}

--meta driven data pipeline to join silver tables and create gold table, highlight this 

SELECT
{% for config_item in config %}
    {{ config_item['columns'] }}{% if not loop.last %}, {% endif %}
{% endfor %}
FROM
{% for config_item in config %}
{% if loop.first %}
    {{ config_item['table'] }} AS {{ config_item['alias'] }}
{% else %}
    JOIN {{ config_item['table'] }} AS {{ config_item['alias'] }}
    ON {{ config_item['join_condition'] }}
{% endif %}
{% endfor %}
