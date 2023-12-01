select
    rank,
    sex,
    age,
    city,
    cause,
    date,
    type,
    general_type,
    date_event_display,
    zone,
    week_num,
    zone_type_union

from {{ ref('stg_emun_victims') }}