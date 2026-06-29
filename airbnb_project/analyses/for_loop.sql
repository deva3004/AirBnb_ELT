{%set col = ['NIGHTS_BOOKED','BOOKING_ID','BOOKING_AMOUNT']%}

SELECT

    {% for c in col %}
        {{c}}{{ "," if not loop.last else "" }}
    {% endfor %}
FROM {{ ref('bronze_bookings') }}
