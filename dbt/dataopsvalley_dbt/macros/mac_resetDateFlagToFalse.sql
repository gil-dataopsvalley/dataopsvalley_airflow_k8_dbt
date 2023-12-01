{% macro mac_resetDateFlagToFalse(column_name) -%}
    case
        when {{ column_name }} = true then false
        else {{ column_name }}
    end as {{ column_name }}
{%- endmacro %}