{{
    config(
        materialized='incremental',
        unique_key = ['Date', 'Hour', 'StationId', 'ServiceId'],
        incremental_strategy='insert_overwrite',
        partition_by = {'field': 'InsertDate', 'data_type': 'datetime'}
        )
}}

select
    Date,
    Hour,
    NumberTransaction,
    Severity,
    Message,
    MachineName,
    Module,
    StationId,
    ServiceId,
    ServiceDisplayNameHebrew,
    StationsTypeDisplayName,
    ServiceLanguage,
    AD_Status,
    --DATE(SPLIT(CAST(DATETIME_TRUNC(insert_date, DAY) as string), 'T')[ORDINAL(1)]) as InsertDate
    InsertDate

from {{ ref('stg_kiosk_log_daily_h') }}
{% if is_incremental() %}
where InsertDate > (select date_sub(max(InsertDate), interval 3 day) from {{ this }})
{% endif %}

