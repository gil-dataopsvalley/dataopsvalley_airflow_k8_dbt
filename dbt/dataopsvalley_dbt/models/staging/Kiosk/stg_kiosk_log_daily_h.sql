select
    SPLIT(date_H, ' ')[ORDINAL(1)] as Date,
    CONCAT(SPLIT(date_H, ' ')[ORDINAL(2)], ':00') as Hour,
    {{ isnull_en_string('severity') }} as Severity,
    {{ isnull_en_string('message') }} as Message,
    {{ isnull_en_string('machineName') }} as MachineName,
    {{ isnull_en_string('module') }} as Module,
    {{ isnull_int('stationId') }} as StationId,
    {{ isnull_int('serviceId') }} as ServiceId,
    {{ isnull_int('cnt') }} as NumberTransaction,
    {{ isnull_he_string('stse.DisplayName') }} as ServiceDisplayNameHebrew,
    {{ isnull_he_string('stse.StationsTypeDisplayName') }} as StationsTypeDisplayName,
    'לא ידוע' as ServiceLanguage,
    {{ isnull_int('stse.AD_Status') }} as AD_Status,
    insert_date as InsertDate

from {{ source('src_kiosk_log_daily_h', 'MRR_KioskLog_Daily_H') }} log
left join {{ source('src_kiosk_stations_services', 'MRR_Kiosk_StationsServices') }} stse
on log.stationId = stse.StationIndex and log.serviceId = stse.ServiceIndex
--left join {{ ref('stg_kiosk_service_language') }} sel
--on log.serviceId = sel.ServiceIndex