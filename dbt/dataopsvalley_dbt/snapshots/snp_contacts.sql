{% snapshot contacts_snapshot %}

{% set new_schema = target.schema + '_snapshot' %}

{{
    config(
      target_schema=new_schema,
      unique_key='CustomerCRMCode',
      strategy='check',
      check_cols=['LastName'],
    )
}}

select * from {{ ref('DWH_DIM_YuvalContact') }}

{% endsnapshot %}
