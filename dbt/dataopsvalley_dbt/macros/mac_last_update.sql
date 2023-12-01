{% macro isCurrentDay() -%}
     current_date()
{%- endmacro %}

{% macro isPreviousDay() -%}
    date_sub(current_date(), interval 1 day)
{%- endmacro %}


