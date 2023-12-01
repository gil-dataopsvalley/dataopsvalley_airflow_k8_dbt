select
    rank,
    sex,
    age,
    city,
    cause,
    {{ cast_mdy_string_date('date', '/') }} as date,
    type,
    general_type,
    case
        when event_date = 'ללא' or event_date = 'לא נבדק'
        then {{ cast_mdy_string_date('death_date', '/') }}
        else {{ cast_mdy_string_date('event_date', '/') }}
    end as date_event_display,
    zone,
    week_num,
    concat(zone, ' - ', type) as zone_type_union
from {{ source('src_emun', 'MRR_Emun_Victims') }}