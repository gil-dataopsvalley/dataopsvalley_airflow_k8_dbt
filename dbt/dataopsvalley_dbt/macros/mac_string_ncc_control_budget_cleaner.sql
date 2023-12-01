{% macro string_ncc_control_budget_cleaner(column_name) -%}
    case when
        trim(replace(replace(replace(replace(replace({{ column_name }}, ' ₪  ', ''), '₪ ', ''), ',', ''), '%', ''), '-', '0')) <> ''
        then trim(replace(replace(replace(replace(replace({{ column_name }}, ' ₪  ', ''), '₪ ', ''), ',', ''), '%', ''), '-', '0'))
    else '0'
    end
{%- endmacro %}