select
    district,
    hospital,
    cast(were_admitted_in_the_last_day as INT) as were_admitted_in_the_last_day,
    cast(hospitalized_for_more_than_a_day as INT) as hospitalized_for_more_than_a_day,
    cast(total as INT) as total,
    cast(total_casualties as INT) as total_casualties

from {{ source('src_emun', 'MRR_Emun_StatusHospitals') }}