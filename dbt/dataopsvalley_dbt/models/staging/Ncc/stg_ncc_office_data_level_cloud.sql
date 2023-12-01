with to_unpivot as(
        select
        name_of_the_office as office_name,
        the_size_of_the_office as office_size,
        specify_maintenance_and_optimization_potential,
        operating_potential_score,
        realization_score,
        readiness_score,
        planning_grade,
        initiation_score

from {{ source('src_ncc', 'MRR_Ncc_Office_Data') }}
)

select  *
from to_unpivot
UNPIVOT(goal_level_cloud FOR office_goals_by_level_cloud
        IN (specify_maintenance_and_optimization_potential,
            operating_potential_score,
            initiation_score,
            planning_grade,
            readiness_score,
            realization_score))