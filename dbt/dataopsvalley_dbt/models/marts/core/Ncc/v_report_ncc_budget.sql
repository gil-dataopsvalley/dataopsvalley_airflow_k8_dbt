{{
    config(materialized='view')
}}

with budgets as (
    select
        project_name,
        incentive_budget,
        office_budget_matching
    from {{ ref('DWH_DIM_Ncc_Dim_Project') }}
    ),

unpivoted as (
    select *,
    from budgets
    UNPIVOT(budget_amount FOR category
            IN (incentive_budget, office_budget_matching))
       )

select
    project_name,
    case
        when category = 'incentive_budget' then 'תקציב תמרוץ'
        when category = 'office_budget_matching' then "(תקציב משרדי (מאצ'ינג"
    end as category,
    budget_amount
from unpivoted




