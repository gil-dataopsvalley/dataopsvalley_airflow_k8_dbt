select
    ProgramID,
    ProgramName

from {{ ref('stg_digital_literacy_programs') }}