{{
    config(materialized='view')
}}

select
    user_hash,
    sup.SupplierName,
    population,
    course_subject,
    course_type,
    prog.ProgramName,
    place,
    rash.he,
    rash.region,
    created_at,
    before_after,
    general_literacy_score_pctil,
    satisfaction_content,
    satisfaction_teaching,
    satisfaction_independent,
    concat(ifnull(SupplierName,''),'',ifnull(course_type,''),'',ifnull(course_subject,''),'',ifnull(place,'')) as program_id,
    totalSatisfaction

from {{ ref('DWH_DIM_DigitalLiteracy_Kayma')}} kayma
left join {{ ref('DWH_DIM_DigitalLiteracy_Supplier') }} sup
on kayma.supplier_name = sup.SupplierID
left join {{ ref('DWH_DIM_DigitalLiteracy_Programs') }} prog
on kayma.course_type =  prog.ProgramID
left join {{ ref('DWH_DIM_DigitalLiteracy_Rashuiot') }} rash
on UPPER(kayma.place) =  rash.key
where prog.ProgramName is not null