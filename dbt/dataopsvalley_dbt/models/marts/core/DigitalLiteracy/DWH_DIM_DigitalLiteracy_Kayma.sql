select
    user_hash,
    supplier_name,
    population,
    course_subject,
    course_type,
    place,
    created_at,
    before_after,
    general_literacy_score_pctil,
    satisfaction_content,
    satisfaction_teaching,
    satisfaction_independent,
    (satisfaction_content + satisfaction_independent + satisfaction_teaching)/3 as totalSatisfaction,
    LastUpdate

from {{ ref('stg_digital_literacy_kayma') }}