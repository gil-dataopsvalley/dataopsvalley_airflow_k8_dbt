
with contacts as (
    select
        concat(FirstName, ' ', LastName) as FullName,
        Mobile,
        ContactEmail
    from {{ ref('DWH_DIM_YuvalContact') }}
),

gcp_projects as (
   select
      bill.date,
      bill.service_id,
      bill.service_description,
      bill.sku_id,
      bill.sku_description,
      bill.net_cost,
      bill.pricing_unit,
      bill.amount_in_pricing_units,
      bill.invoice_month as invoiceMonth,
      {{ isnull_project_id('bill.projectId') }} as project_id,
      bill.organizationId as organization_id,
      bill.organizationName as organization_name,
      metadata.project_status,
      metadata.department,
      {{ convert_email_label('metadata.owners_group_email') }} as owner_email,
      metadata.environment,
      {{ isnull_product_name('metadata.product_name') }} as product_name,
      metadata.merkava_purchase_order_number,
      metadata.merkava_ministry_id,
      case metadata.ministry_name
            when "m-digital" then "GOV"
            else metadata.ministry_name
      end as ministry_name,
      metadata.account_name,
      metadata.owner_contact

    from {{ ref('stg_billboard_daily') }} as bill
    left join {{ ref('stg_gcp_metadata') }} as metadata
    on bill.projectId = metadata.project_id
)

select
    gcp_projects.*,
    contacts.FullName as product_manager_name,
    contacts.Mobile,

from gcp_projects
left join contacts
on contacts.ContactEmail = gcp_projects.owner_email





