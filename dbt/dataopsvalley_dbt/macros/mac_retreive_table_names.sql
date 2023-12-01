{% macro get_column_values(column_name, relation) %}

{% set table_names_query %}
    select distinct  {{ column_name }} from {{ relation }}
{% endset %}

{% set results = run_query(table_names_query) %}

{% if execute %}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}
{% endmacro %}
