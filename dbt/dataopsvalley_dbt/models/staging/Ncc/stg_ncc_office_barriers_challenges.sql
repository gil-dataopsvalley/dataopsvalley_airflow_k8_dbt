select
    name_of_the_office as office_name,
    barriers

from {{ source('src_ncc', 'MRR_Ncc_Office_BarriersChallenges') }}
