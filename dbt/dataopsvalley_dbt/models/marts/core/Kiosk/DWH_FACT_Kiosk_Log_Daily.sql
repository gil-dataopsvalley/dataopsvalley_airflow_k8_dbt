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
    SUM(NumberTransaction) as NumberTransaction,
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
    InsertDate

from {{ ref('DWH_FACT_Kiosk_Log_Daily_H') }}

{% if is_incremental() %}
where InsertDate >= (select date_sub(max(InsertDate), interval 3 day) from {{ this }})
{% endif %}

group by Date,
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
    InsertDate
