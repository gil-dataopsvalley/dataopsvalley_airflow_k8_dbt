select
    school_type,
    status,
    cast(count as INT) as count
from {{ source('src_emun', 'MRR_Emun_CurrentInformationMinistryEducation') }}