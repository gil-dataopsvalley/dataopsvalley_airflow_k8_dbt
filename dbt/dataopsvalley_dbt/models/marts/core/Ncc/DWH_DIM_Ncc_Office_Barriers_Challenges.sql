select
    office_name,
    barriers
from {{ ref('stg_ncc_office_barriers_challenges') }}