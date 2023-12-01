{{
    config(materialized='view')
}}

select
    date.DateFull as Date,
    Hour,
    ServiceDisplayNameHebrew,
    st.StationName,
    ServiceLanguage,
    NumberTransaction,
    date.DayOfMonth,
    date.DayOfWeek,
    date.WeekDay,
    date.DayOfWeekDesc,
    date.IsYesterdayDate,
    date.IsCurrentMonth,
    date.IsCurrentYear,
    date.IsCurrentWeek,
    date.MonthNum,
    date.DateId,
    st.StationStatusCodeName,
    st.CustomerName,
    st.Pop_TypeName,
    st.LocationNameCategory,
    st.PrinterTypeName,
    st.IdCardReaderName,
    st.ComputerName,
    st.CreditCardReaderType,
    st.WindowsTypeName,
    st.IsForBI,
    st.UnitName,
    st.Address,
    st.KioskLocationName,
    st.LocationName,
    st.StationDefaultLanguageName,
    st.Town

from {{ ref('DWH_FACT_Kiosk_Log_Daily_H') }} log
left join {{ ref('DWH_DIM_Kiosk_Station') }} st
on log.StationId = st.StationID
inner join {{ ref('DWH_DIM_Date') }} date
on cast(log.Date as Date) = date.DateFull
where st.IsForBI = 1