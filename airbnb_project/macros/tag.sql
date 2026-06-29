{% macro tag(column_name) %}
    CASE
        WHEN {{ column_name }} < 100 THEN 'LOW'
        WHEN {{ column_name }} < 200 THEN 'MEDIUM'
        WHEN {{ column_name }} < 300 THEN 'HIGH'
        ELSE 'VERY HIGH'
    END
{% endmacro %}