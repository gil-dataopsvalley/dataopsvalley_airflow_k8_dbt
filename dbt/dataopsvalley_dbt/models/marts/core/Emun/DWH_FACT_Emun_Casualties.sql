select
    date,
    number_of_casualties

from {{ ref('stg_emun_casualties') }}