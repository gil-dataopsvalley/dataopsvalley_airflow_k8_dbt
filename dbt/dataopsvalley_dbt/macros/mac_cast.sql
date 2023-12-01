{% macro castMicroSecondToSecond(column_name) -%}
     round(cast({{ column_name }} as FLOAT64)/1000000,2)
{%- endmacro %}

{% macro castToInt(column_name) -%}
     cast({{ column_name }} as INT)
{%- endmacro %}


