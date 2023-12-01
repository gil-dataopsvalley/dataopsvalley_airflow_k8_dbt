
select
    DateId,
    DateFull,
    WeekNum,
    MonthNum,
    QuarterNum,
    YearNum,
    {{ mac_resetDateFlagToFalse('IsCurrentDay') }},
    {{ mac_resetDateFlagToFalse('IsCurrentWeek') }},
    {{ mac_resetDateFlagToFalse('IsCurrentMonth') }},
    {{ mac_resetDateFlagToFalse('IsCurrentQuarter') }},
    {{ mac_resetDateFlagToFalse('IsCurrentYear') }},
    {{ mac_resetDateFlagToFalse('IsYesterdayDate') }},
    {{ mac_resetDateFlagToFalse('IsPreviousMonth') }},
    {{ mac_resetDateFlagToFalse('IsPrevious2Month') }},
    {{ mac_resetDateFlagToFalse('IsPreviousMTD') }},
    {{ mac_resetDateFlagToFalse('IsPreviousYTD') }},
    {{ mac_resetDateFlagToFalse('IsTodayMTD') }},
    {{ mac_resetDateFlagToFalse('IsTodayYTD') }},
    DateFullWithTime,
    DayOfYear,
    DayOfQuarter,
    DayOfMonth,
    DayOfWeek,
    DayOfWeekDesc,
    concat(DayOfWeek, '_', DayOfWeekDesc) as WeekDay,
    MonthDesc,
    QuarterDesc,
    MonthYearDesc,
    QuarterYearDesc,
    WeekYear,
    QuarterYear,
    MonthYear,
    {{ mac_resetDateFlagToFalse('IsTodayDate') }},
    {{ mac_resetDateFlagToFalse('IsTodayWeek') }},
    {{ mac_resetDateFlagToFalse('IsTodayMonth') }},
    {{ mac_resetDateFlagToFalse('IsTodayQuarter') }},
    {{ mac_resetDateFlagToFalse('IsTodayYear') }},
    {{ mac_resetDateFlagToFalse('IsPeriodYearAgo') }},
    {{ mac_resetDateFlagToFalse('IsPeriod2FullYears') }},
    {{ mac_resetDateFlagToFalse('IsPeriodWeekAgo') }},
    {{ mac_resetDateFlagToFalse('IsPeriodYearAgoWithToday') }},
    DateDesc


from {{ source('src_calendar', 'DWH_DIM_Date') }}
