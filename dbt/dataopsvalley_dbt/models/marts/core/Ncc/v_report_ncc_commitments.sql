{{
    config(materialized='view')
}}

with budgets as (
    select
        project_name,
        incentive_budget_commitment,
        office_budget_commitment_matching
    from {{ ref('DWH_DIM_Ncc_Dim_Project') }}
    ),

unpivoted as (
    select *,
    from budgets
    UNPIVOT(commit_budget_amount FOR category
            IN (incentive_budget_commitment, office_budget_commitment_matching))
       )

select
    project_name,
    case
        when category = 'incentive_budget_commitment' then 'התחייבות תקציב תמרוץ'
        when category = 'office_budget_commitment_matching' then "(התחייבות תקציב משרדי (מאצ'ינג"
    end as category,
    commit_budget_amount
from unpivoted




