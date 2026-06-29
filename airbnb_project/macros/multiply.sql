{% macro multiply(x, y, precision) %}
    ROUND({{ x }}, {{ precision }}) * ROUND({{ y }}, {{ precision }})
{% endmacro %}