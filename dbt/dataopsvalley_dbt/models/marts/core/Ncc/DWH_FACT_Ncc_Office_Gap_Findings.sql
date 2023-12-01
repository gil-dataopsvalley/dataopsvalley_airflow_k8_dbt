select
    office_name,
    office_size,
    gaps

from {{ ref('stg_ncc_office_gap_findings') }}