select
    date,
    EvacType,
    NumberOfEvacuees,
    FlagMaxDate
from {{ ref('stg_emun_evacuees_by_shalter_type') }}