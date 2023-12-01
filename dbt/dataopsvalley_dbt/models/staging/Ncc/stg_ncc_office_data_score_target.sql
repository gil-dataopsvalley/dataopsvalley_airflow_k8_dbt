with to_unpivot as(
        select
        name_of_the_office as office_name,
        the_size_of_the_office as office_size,
        human_capital_score,
        tsion_independence_of_the_office_in_the_journey_to_the_cloud,
        specify_the_ability_to_deal_with_the_barriers,
        office_motivation_score,
        optimal_assignment_score
from {{ source('src_ncc', 'MRR_Ncc_Office_Data') }}
)

select *
from to_unpivot
UNPIVOT(goal_targets FOR targets
        IN (human_capital_score,
            tsion_independence_of_the_office_in_the_journey_to_the_cloud,
            specify_the_ability_to_deal_with_the_barriers,
            office_motivation_score,
            optimal_assignment_score))

