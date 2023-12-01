    select
        user_hash,
        supplier_name,
        case
            when population = 'haredi' then 'החברה החרדית'
            when population = 'arab' then 'החברה הערבית'
            when population = 'senior' then 'אזרחים ותיקים'
            when population = 'russian' then 'החברה רוסית'
            when population = 'other' then 'יתר האוכלוסיה'
            else population end
        as population,
        case
            when course_subject = 'finance' then 'פיננסי'
            when course_subject = 'communication' then 'תקשורת'
            when course_subject = 'health' then 'בריאות'
            when course_subject = 'civ' then 'אזרחות ומיצוי'
            when course_subject = 'fun' then 'פנאי'
            when course_subject = 'consumption' then 'צרכנות'
            when course_subject = 'other' then 'אחר'
        else course_subject end
        as course_subject,
        course_type,
        place,
        created_at,
        before_after,
        general_literacy_score_pctil,
        cast(satisfaction_content as FLOAT64) as satisfaction_content,
        cast(satisfaction_teaching as FLOAT64) as satisfaction_teaching,
        cast(satisfaction_independent as FLOAT64) as satisfaction_independent,
        {{ isCurrentDay() }} as LastUpdate
   from {{ source('src_digital_literacy', 'MRR_DigitalLiteracy_Kayma') }}

