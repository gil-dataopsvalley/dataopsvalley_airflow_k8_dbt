{% macro isnull_he_string(column_name) -%}
    case when {{ column_name }} is null
            or {{ column_name }} = ''
         then 'לא ידוע'
         else {{ column_name }}
    end
{%- endmacro %}

{% macro isnull_en_string(column_name) -%}
    IFNULL({{ column_name }} , 'Unknown')
{%- endmacro %}

{% macro isnull_string_to_int(column_name) -%}
    cast(case when {{ column_name }} is null
            or trim({{ column_name }}) = ''
         then '-1'
         else trim(replace({{ column_name }}, ',', ''))
    end as int)
{%- endmacro %}

{% macro isnull_int(column_name) -%}
    IFNULL({{ column_name }} , -1)
{%- endmacro %}

{% macro isnull_guid(column_name) -%}
    IFNULL({{ column_name }} , "CFD15631-830B-447C-B5AF-C6D639CF2F1C")
{%- endmacro %}

{% macro isnull_project_id(column_name) -%}
    IFNULL({{ column_name }} , 'Shared-GCP-Services')
{%- endmacro %}

{% macro isnull_product_name(column_name) -%}
    IFNULL({{ column_name }} , 'Unnamed-Product')
{%- endmacro %}



