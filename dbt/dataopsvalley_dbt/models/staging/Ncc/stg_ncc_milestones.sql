select
  milestone_number,
  milestone_description,
  milestone_budget,
  milestone_execution_status,
  case when milestone_execution_status = 'בוצעה' then 1 else 0 end as executed_milestone,
  case when milestone_execution_status = 'בתהליך עבודה' then 1 else 0 end as onboarding_milestone,
  case when milestone_execution_status = 'טרם' then 1 else 0 end as before_execution_milestone,
  execution_date,
  filename

from {{ source('src_ncc', 'MRR_Ncc_Milestones')}}