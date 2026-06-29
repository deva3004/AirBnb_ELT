{{
config(
    materialized='ephemeral',
    schema='gold'
)
}}

WITH BOOKING AS (
    SELECT
        BOOKING_ID,
        BOOKING_DATE,
        BOOKING_STATUS,
        BOOKING_CREATED_AT
    
    FROM
        {{ref('obt')}}
)
SELECT * FROM BOOKING