{{
    config(materialized='view')
}}

select
    Date,
    ServiceDisplayNameHebrew,
    StationName,
    'הצלחה' as success_message,
    log.ServiceLanguage,
    StationDefaultLanguageName,
    KioskLocationName,
    Pop_TypeName,
    Town,
    NumberTransaction

from {{ ref('DWH_DIM_Kiosk_Station') }} st
inner join {{ ref('DWH_FACT_Kiosk_Log_Daily') }} log
on st.StationID = log.StationId