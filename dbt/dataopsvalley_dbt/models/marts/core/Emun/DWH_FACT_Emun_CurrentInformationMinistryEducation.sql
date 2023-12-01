select
    school_type,
    status,
    count

from {{ ref('stg_emun_current_information_ministry_education') }}