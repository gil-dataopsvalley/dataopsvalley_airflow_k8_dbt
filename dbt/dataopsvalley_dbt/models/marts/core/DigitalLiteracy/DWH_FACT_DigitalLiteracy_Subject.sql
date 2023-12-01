select
    user_hash,
    created_at,
    source_name,
    before_after,
    gender,
    age,
    population,
    supplier_name,
    course_type,
    course_subject,
    starting_date,
    place,
    device,
    teaching_method,
    teacher_name,
    case
        when Attribute = 'consumption' then 'צרכנות'
        when Attribute = 'finance' then 'פיננסי'
        when Attribute = 'health' then 'בריאות'
        when Attribute = 'civ' then 'אזרחות ומיצוי זכויות'
        when Attribute = 'communication' then 'תקשורת'
        when Attribute = 'fun' then 'פנאי ובידור'
    end as Attribute,
    Value

from {{ ref('stg_digital_literacy_subject') }}