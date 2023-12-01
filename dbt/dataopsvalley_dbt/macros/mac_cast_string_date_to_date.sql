{% macro cast_dmy_string_date(date_column, separator) -%}
     cast(FORMAT_DATE('%F', DATE(cast(SPLIT({{ date_column }}, '{{ separator }}')[ORDINAL(3)] as int),
                                cast(SPLIT({{ date_column }}, '{{ separator }}')[ORDINAL(2)] as int),
                                cast(SPLIT({{ date_column }} , '{{ separator }}')[ORDINAL(1)] as int))) as DATE)
{%- endmacro %}

{% macro cast_mdy_string_date(date_column, separator) -%}
     cast(FORMAT_DATE('%F', DATE(cast(SPLIT({{ date_column }}, '{{ separator }}')[ORDINAL(3)] as int),
                                cast(SPLIT({{ date_column }}, '{{ separator }}')[ORDINAL(1)] as int),
                                cast(SPLIT({{ date_column }} , '{{ separator }}')[ORDINAL(2)] as int))) as DATE)
{%- endmacro %}