{{
    config(materialized='view')
}}

select
    rep.user_hash,
    rep.SupplierName,
    rep.population,
    rep.course_subject,
    rep.course_type,
    rep.ProgramName,
    rep.place,
    rep.he,
    rep.region,
    rep.created_at,
    rep.before_after,
    rep.general_literacy_score_pctil,
    rep.satisfaction_content,
    rep.satisfaction_teaching,
    rep.satisfaction_independent,
    rep.program_id,
    rep.totalSatisfaction,
    sub.source_name,
    sub.gender,
    sub.age,
    sub.starting_date,
    sub.device,
    sub.teaching_method,
    sub.teacher_name,
    sub.Attribute,
    sub.Value

from {{ ref('v_report_DigitalLiteracy') }} rep
join {{ ref('DWH_FACT_DigitalLiteracy_Subject') }} sub
using (user_hash)