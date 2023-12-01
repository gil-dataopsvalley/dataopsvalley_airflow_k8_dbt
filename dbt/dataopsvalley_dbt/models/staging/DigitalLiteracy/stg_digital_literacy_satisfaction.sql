with to_unpivot as(
    select
        user_hash,
        created_at,
        source_name,
        url_param_sapak,
        url_param_src,
        project,
        before_after,
        language,
        religion,
        religion_level,
        vatikim,
        gender,
        age,
        consumption,
        finance,
        health,
        civ,
        communication,
        fun,
        employment,
        satisfaction_teaching,
        satisfaction_content,
        satisfaction_independent,
        motiv_time,
        motiv_social,
        motiv_fun,
        motiv_economic,
        motiv_info,
        motiv_work,
        motiv_religion,
        motiv_no_choice,
        motiv_barrier_privacy,
        motiv_barrier_language,
        motiv_barrier_wrong_info,
        motiv_barrier_lifestyle,
        motiv_barrier_religion,
        motiv_barrier_investment,
        motiv_barrier_waste,
        motiv_barrier_other_person,
        domains_scales,
        general_literacy_score,
        population,
        supplier_name,
        course_type,
        course_subject,
        starting_date,
        place,
        device,
        teaching_method,
        teacher_name,
        general_literacy_score_pctil,
        class_id

   from {{ source('src_digital_literacy', 'MRR_DigitalLiteracy_Kayma') }}
)

select *
from to_unpivot
UNPIVOT(Value FOR Attribute
        IN (satisfaction_teaching, satisfaction_content, satisfaction_independent, class_id))



