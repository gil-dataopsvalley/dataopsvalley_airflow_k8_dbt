select
    date_of_submission,
    involuntary_unpaid_leave,
    other_reasons,
    total

from {{ ref('stg_emun_unemployment') }}