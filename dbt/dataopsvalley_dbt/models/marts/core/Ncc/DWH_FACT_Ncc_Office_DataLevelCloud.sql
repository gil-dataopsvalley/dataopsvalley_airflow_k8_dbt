select
    office_name,
    office_size,
    goal_level_cloud,
    case when office_goals_by_level_cloud = 'specify_maintenance_and_optimization_potential' then 'פוטנציאל תחזוקה ואופטימיזציה'
         when office_goals_by_level_cloud = 'operating_potential_score' then 'פוטנציאל תפעול'
         when office_goals_by_level_cloud = 'initiation_score' then 'ייזום'
         when office_goals_by_level_cloud = 'planning_grade' then 'תכנון'
         when office_goals_by_level_cloud = 'readiness_score' then 'מוכנות'
         when office_goals_by_level_cloud = 'realization_score' then 'מימוש'
    end as office_goals_by_level_cloud
    

from {{ ref('stg_ncc_office_data_level_cloud') }}