
{{
    config(materialized='view')
}}

select
    CustomerName,
    Domain,
    Organization,
    PaymentsCount,
    PaymentsSum,
    DateLastChanged,
    OfficeNameEcom,
    TransactionType,
    PayMethodDesc,
    PayMethodCategory,
    OneclickPayMethod,
    CcMutag,
    CommerceName,
    ServiceDesc,
    date.YearNum,
    date.DayOfWeekDesc,
    date.WeekDay,
    date.MonthYearDesc,
    date.IsCurrentYear

from {{ ref('DWH_FACT_Ecom_Payment') }} ecom
inner join {{ ref('DWH_DIM_Date') }} date
on cast(ecom.DateLastChanged as DATE) = date.DateFull