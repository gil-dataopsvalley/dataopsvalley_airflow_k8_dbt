select
    office_name,
    office_size,
    goal_targets,
    case when targets = 'human_capital_score' then 'הון אנושי'
         when targets = 'tsion_independence_of_the_office_in_the_journey_to_the_cloud' then 'עצמאות משרדית'
         when targets = 'specify_the_ability_to_deal_with_the_barriers' then 'יכולת התמודדות עם חסמים'
         when targets = 'office_motivation_score' then 'מוטיבציה משרדית'
         when targets = 'optimal_assignment_score' then 'הקצאת משאבים מיטבית'
    end as targets

from {{ ref('stg_ncc_office_data_score_target') }}