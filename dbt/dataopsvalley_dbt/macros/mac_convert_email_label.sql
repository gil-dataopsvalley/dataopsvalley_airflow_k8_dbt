{% macro convert_email_label(column_name) -%}
     replace(replace({{ column_name }}, '-at-', '@'), '-', '.')
{%- endmacro %}