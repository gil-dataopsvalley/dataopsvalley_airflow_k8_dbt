with
GCP_MetaData as
( SELECT  metadata.project_id,
          project_number,
          metadata.project_status,
          metadata.department,
          replace(replace(metadata.owners_group_email, "-at-", "@"), "-", ".") as owners_group_email,
          metadata.environment,
          replace(metadata.product_name, "-", " ") as product_name,
          case metadata.ministry_name
            when "m-digital" then "GOV"
            else metadata.ministry_name
          end as ministry_name,
          merkava_purchase_order_number,
          merkava_ministry_id,
          account_name

  FROM {{ ref('stg_gcp_metadata') }} as metadata
),

mtd_billboard as (
    select
        project_id,
        current_invoice_month,
        current_month_budget,
        billing_balance_mtd,
        billing_usage_mtd
    from {{ ref('stg_billboard_monthly') }}
)


SELECT  metadata.project_id,
        metadata.project_number,
        metadata.project_status,
        metadata.department,
        metadata.owners_group_email,
        metadata.environment,
        metadata.product_name,
        metadata.ministry_name,
        metadata.merkava_purchase_order_number,
        metadata.merkava_ministry_id,
        metadata.account_name,

        -- Contact fields. These values are used instead of label values.
        concat(contact.FirstName, " ", contact.LastName) as Contact_Name,
        contact.Mobile as Contact_Mobile,

        -- Customer fields. These values are used instead of label values.
        customer.CustomerName,

        -- Budget fields
        budgets.budget_display_name,
        budgets.budget_calendar_period,

        -- Billing MTD fields
        mtd_billboard.current_invoice_month,
        mtd_billboard.current_month_budget,
        mtd_billboard.billing_balance_mtd,
        mtd_billboard.billing_usage_mtd,
        -- calculate percents
        {{ isCurrentDay() }} as LastUpdate

FROM GCP_MetaData as metadata

left join {{ ref('DWH_DIM_YuvalContact') }} as contact
  on metadata.owners_group_email = contact.ContactEmail

left join {{ ref('DWH_DIM_YuvalCustomer') }} as customer
  on metadata.ministry_name = customer.Domain

left join {{ ref('stg_gcp_budget') }} as budgets
  on metadata.project_id = budgets.project_id

left join mtd_billboard
  on metadata.project_id = mtd_billboard.project_id

-- לחבר ליובל: לפי מוצר
