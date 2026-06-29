{{
config(
    materialized='ephemeral',
    schema='gold'
)
}}

WITH HOSTS AS (
    SELECT
        HOST_ID,
        HOST_NAME,
        HOST_SINCE,
        IS_SUPERHOST,
        RESPONSE_RATE_QUALITY,
        HOST_CREATED_AT
    FROM
        {{ref('obt')}}
)
SELECT * FROM HOSTS