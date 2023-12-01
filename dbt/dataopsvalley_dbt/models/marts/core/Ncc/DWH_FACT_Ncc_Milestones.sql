select
  milestone_number,
  milestone_description,
  milestone_budget,
  milestone_execution_status,
  executed_milestone,
  onboarding_milestone,
  before_execution_milestone,
  execution_date,
  filename

from {{ ref('stg_ncc_milestones')}}