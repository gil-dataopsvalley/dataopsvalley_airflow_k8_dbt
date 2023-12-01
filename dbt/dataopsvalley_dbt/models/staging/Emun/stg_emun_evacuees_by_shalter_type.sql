with raw_data as (
    select
        {{ cast_dmy_string_date('date', '/') }} as date,
        EvacType,
        cast(NumberOfEvacuees as int) as NumberOfEvacuees
    from {{ source('src_emun', 'MRR_Emun_EvacueesByShalterType') }}
    ),

    ranked_data as (
    select
        date,
        EvacType,
        NumberOfEvacuees,
        RANK() OVER (partition by EvacType ORDER BY date DESC) as rank_flag
    from raw_data
    )

    select
        date,
        EvacType,
        NumberOfEvacuees,
        case when rank_flag = 1 then 1 else 0 end as FlagMaxDate
    from ranked_data

