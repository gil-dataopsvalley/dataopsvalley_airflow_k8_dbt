with pre_budgets as
(
  select
     ARRAY_TO_STRING(budget_filter.project, " ")  as project_string,
     display_name as budget_display_name,
     budget_filter.calendar_period as budget_calendar_period,
--     budget_filter.service as budget_service,
--     budget_filter.resource_ancestor as budget_resource_ancestor,
     budget_amount.units as budget_units

  from {{ source('src_gcp_budget', 'MRR_GCP_Budgets') }}
  where ARRAY_TO_STRING(budget_filter.project, " ") like 'projects/%'
),

budgets as
(
  select  replace(project_string, "projects/", "") as project_number,
          budget_display_name,
          budget_calendar_period,
          budget_units
  from pre_budgets
  where project_string not like '% %'
),

gcp_metadata as (
    select
        project_id,
        project_number
    from {{ ref('stg_gcp_metadata') }}
    )

  select  gcp_metadata.project_id,
          gcp_metadata.project_number,
          budgets.budget_display_name,
          budgets.budget_calendar_period,
          budgets.budget_units
  from budgets
  inner join gcp_metadata
  on budgets.project_number = gcp_metadata.project_number
