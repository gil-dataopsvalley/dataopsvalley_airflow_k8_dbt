select
    district,
    hospital,
    were_admitted_in_the_last_day,
    hospitalized_for_more_than_a_day,
    total,
    total_casualties

from {{ ref('stg_emun_status_hospitals') }}