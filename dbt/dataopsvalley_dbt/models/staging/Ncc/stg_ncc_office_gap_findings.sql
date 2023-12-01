select
    name_of_the_office as office_name,
    office_size,
    gaps

from {{ source('src_ncc', 'MRR_Ncc_Office_GapFindings') }}
