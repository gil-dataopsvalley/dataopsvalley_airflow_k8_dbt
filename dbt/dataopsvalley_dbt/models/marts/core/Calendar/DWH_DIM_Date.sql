
with dates as (
    select * from {{ ref('stg_calendar') }}
),

final as (
    select
        DateId,
        DateFull,
        WeekNum,
        MonthNum,
        QuarterNum,
        YearNum,
        case
            when DateFull = CURRENT_DATE()
                then true
            else IsCurrentDay
        end as IsCurrentDay,
        case
            when DateFull = DATE_SUB(CURRENT_DATE() , INTERVAL 1 DAY)
                then true
            else IsYesterdayDate
        end as IsYesterdayDate,
        case
            when EXTRACT(week from CURRENT_DATE()) = WeekNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsCurrentWeek
        end as IsCurrentWeek,
        case
            when EXTRACT(month from CURRENT_DATE()) = MonthNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsCurrentMonth
        end as IsCurrentMonth,
        case
            when EXTRACT(quarter from CURRENT_DATE()) = QuarterNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsCurrentQuarter
        end as IsCurrentQuarter,
        case
            when EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsCurrentYear
        end as IsCurrentYear,
        case
            when EXTRACT(month from CURRENT_DATE()) = MonthNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                and CURRENT_DATE() >= DateFull
                then true
            else IsTodayMTD
        end as IsTodayMTD,
        case
            when EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                and CURRENT_DATE() >= DateFull
                then true
            else IsTodayYTD
        end as IsTodayYTD,
        case
            when EXTRACT(month from CURRENT_DATE())-1 = MonthNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsPreviousMonth
        end as IsPreviousMonth,
        case
            when EXTRACT(month from CURRENT_DATE())-2 = MonthNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                then true
            else IsPrevious2Month
        end as IsPrevious2Month,
        case
            when EXTRACT(month from DATE_SUB(CURRENT_DATE() , INTERVAL 1 MONTH)) = MonthNum
                and EXTRACT(year from CURRENT_DATE()) = cast(YearNum as int)
                and DATE_SUB(CURRENT_DATE() , INTERVAL 1 MONTH) >= DateFull
                then true
            else IsPreviousMTD
        end as IsPreviousMTD,
        case
            when EXTRACT(year from DATE_SUB(CURRENT_DATE() , INTERVAL 1 year)) = cast(YearNum as int)
                and DATE_SUB(CURRENT_DATE() , INTERVAL 1 year) >= DateFull
                then true
            else IsPreviousYTD
        end as IsPreviousYTD,
        DateFullWithTime,
        DayOfYear,
        DayOfQuarter,
        DayOfMonth,
        DayOfWeek,
        DayOfWeekDesc,
        WeekDay,
        MonthDesc,
        QuarterDesc,
        MonthYearDesc,
        QuarterYearDesc,
        WeekYear,
        QuarterYear,
        MonthYear,
        IsTodayDate,
        IsTodayWeek,
        IsTodayMonth,
        IsTodayQuarter,
        IsTodayYear,
        IsPeriodYearAgo,
        IsPeriod2FullYears,
        IsPeriodWeekAgo,
        IsPeriodYearAgoWithToday,
        DateDesc

    from dates
)

select * from final


