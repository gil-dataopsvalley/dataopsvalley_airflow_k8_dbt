with bill_usage as (
    select
        bill.project_id,
        bill.invoiceMonth,
        budgets.budget_units,
        sum(bill.net_cost) as billing_usage

    from {{ ref('stg_billboard_daily_gcp_metadata') }} as bill
    left join {{ ref('stg_gcp_budget') }} budgets
    on budgets.project_id = bill.project_id
    where FORMAT_DATE('%Y%m', CURRENT_DATE()) = bill.invoiceMonth
    group by bill.project_id, bill.invoiceMonth, budgets.budget_units
    )

select
    project_id,
    invoiceMonth as current_invoice_month,
    budget_units as current_month_budget,
    cast(budget_units as int) - cast(billing_usage as int) as billing_balance_mtd,
    cast(billing_usage as int) as billing_usage_mtd

from bill_usage
