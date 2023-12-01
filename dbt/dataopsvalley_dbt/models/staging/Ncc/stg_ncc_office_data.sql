select
    name_of_the_office as office_name,
    the_size_of_the_office as office_size,
    initiation_score, -- ציון ייזום
    planning_grade as planning_score, -- ציון תכנון
    readiness_score, -- ציון מוכנות
    realization_score, --ציון מימוש
    operating_potential_score, -- ציון פוטנציאל תפעול
    specify_maintenance_and_optimization_potential as maintenance_and_optimization_potential_score, -- ציון פוטנציאל תחזוקה ואופוטימיזציה
    weighted_score, --  ציון משוקלל
    office_motivation_score, -- ציון מוטיבציה משרדית
    tsion_independence_of_the_office_in_the_journey_to_the_cloud as office_independence_in_the_migration_to_cloud_score, -- ציון עצמאות המשרדית במסע לענן
    specify_the_ability_to_deal_with_the_barriers as ability_to_deal_with_barriers_score, -- ציון יכולת להתמודד עם החסמים
    human_capital_score, -- ציון הון אנושי
    optimal_assignment_score, -- ציון הקצאה מיטבית
    block_planning__management_and_budget_execution__including_finops_ as planning_and_management_and_budget_execution_including_finops_barrier, -- חסם תכנון ניהול וביצוע תקציב כולל finops
    hashem_level_of_organizational_knowledge_and_training as organizational_knowledge_level_and_trainings_barrier, -- חסם רמת ידע ארגוני והכשרות
    block_recruitment_of_personnel as recruitment_barrier, -- חסם גיוס כוח אדם
    procurement_block_and_supplier_management as procurement_and_supplier_management_barrier, -- חסם רכש וניהול ספקים
    block_the_commitment_of_the_office_management as office_management_commitment_barrier, -- חסם מחויבות הנהלת המשרד
    technological_barrier___technical as technological_technical_barrier, -- חסם טכנולוגי טכני
    block_landing_zone as landing_zone_barrier, -- חסם landing zone
    block_information_security as information_security_barrier, -- חסם אבטחת מידע
    block_1 as barrier_1,
    block_2 as barrier_2,
    block_3 as barrier_3,
    block_4 as barrier_4,
    block_5 as barrier_5

from {{ source('src_ncc', 'MRR_Ncc_Office_Data') }}