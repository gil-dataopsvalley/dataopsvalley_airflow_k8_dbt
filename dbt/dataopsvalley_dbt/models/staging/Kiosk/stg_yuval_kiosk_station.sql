select distinct
    {{ isnull_int('st.statuscode') }} as StationStatusCode,
    {{ isnull_int('st.statecode') }} as StationStateCode,
    {{ isnull_he_string('st.statuscodename') }} as StationStatusCodeName,
    {{ isnull_he_string('st.statecodename') }} as StationStateCodeName,
    {{ isnull_he_string('yuval_0') }} as StationComment,
    {{ isnull_he_string('yuval_address') }} as Address,
    {{ isnull_en_string('yuval_computernamename') }} as ComputerName,
    yuval_cord_x as CordX,
    yuval_cord_y as CordY,
    {{ isnull_en_string('yuval_creditcardreadertypename') }} as CreditCardReaderType,
    {{ isnull_he_string('yuval_defaultlanguagename') }} as StationDefaultLanguageName,
    yuval_deploymentstatus as DeploymentStatusName,
    {{ isnull_en_string('yuval_displayname') }} as DisplayNameTahbura,
    {{ isnull_en_string('yuval_externalid') }} as ExternalIDNameGovIl,
    {{ isnull_int('yuval_fingerreader') }} as FingerReader,
    stsr.StationIndex as StationID,
    {{ isnull_en_string('yuval_idcardreadername') }} as IdCardReaderName,
    {{ isnull_en_string('yuval_ironnumber') }} as IronNumber,
    {{ isnull_he_string('yuval_kiosk_locationname') }} as LocationName,
    {{ isnull_int('yuval_kiosk_modelname') }} as ModelName,
    yuval_latitude as Latitude,
    {{ isnull_en_string('yuval_line_codename') }} as LineCodeName,
    {{ isnull_en_string('yuval_loadingresponsibilityname') }} as LoadingResponsibilityName,
    yuval_longitude as Longitude,
    {{ isnull_en_string('yuval_modemip') }} as ModemIp,
    {{ isnull_he_string('yuval_pop_typename') }} as Pop_TypeName,
    {{ isnull_en_string('yuval_printertypename') }} as PrinterTypeName,
    {{ isnull_int('yuval_proximitysensor') }} as ProximitySensor,
    {{ isnull_int('yuval_scanner') }} as Scanner,
    {{ isnull_en_string('yuval_stationip') }} as StationIP,
    {{ isnull_he_string('yuval_town') }} as Town,
    {{ isnull_he_string('yuval_unitname') }} as UnitName,
    {{ isnull_en_string('yuval_windowstypename') }} as WindowsTypeName,
    {{ isnull_int('stsr.AD_Status') }} as IsForBI,
    {{ isnull_guid('yuval_office') }} as CustomerCRMCode,
    {{ isnull_he_string('cus.CustomerName') }} as CustomerName,
    {{ isnull_he_string('loc.yuval_kiosk_location') }} as KioskLocationName,
    {{ isnull_he_string('loc.yuval_kiosk_location_typename') }} as LocationNameCategory,
    IFNULL(yuval_name, stsr.BackOfficeDisplayName) as StationName,
    st.yuval_id as Yuval_Station_ID


from {{ source('src_yuval_kiosk_station', 'MRR_Yuval_Kiosk_Station') }} st
left join {{ ref('DWH_DIM_YuvalCustomer') }} cus
on st.yuval_office = cus.CustomerCRMCode
left join {{ source('src_yuval_kiosk_location', 'MRR_Yuval_kiosk_location') }} loc
on st.yuval_kiosk_location = loc.yuval_kiosk_locationid
left join {{ source('src_kiosk_stations_services', 'MRR_Kiosk_StationsServices') }} stsr
on cast(st.yuval_id as int) = stsr.StationIndex
where st.yuval_id is not null
    and stsr.AD_Status = 1

