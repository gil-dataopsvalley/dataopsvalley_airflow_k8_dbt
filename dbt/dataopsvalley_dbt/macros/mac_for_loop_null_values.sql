
{% macro null_values_fields(table_name) -%}
    {{ log("table_name: " ~ table_name, True) }}
    {% set table_ref = ref(table_name) %}
    {% set nulls_query %}
    select concat(col_name, '_', cast(COUNT(1) as string)) as field_nulls_cnt
    from {{ table_ref }} as t,
    UNNEST(REGEXP_EXTRACT_ALL(TO_JSON_STRING(t), r'"(\w+)":null')) col_name
    GROUP BY col_name
    {% endset %}

    {{ log("query: " ~ nulls_query, True) }}
    {% set results = run_query(nulls_query) -%}

    {% set results_list = results.columns[0].values() %}
    {{ log("results_list: " ~ results_list, True) }}
    {{ return(results_list) }}


{%- endmacro %}
