with data as (
    SELECT
      date,
      service.id as service_id,
      service.description as service_description,
      sku.id as sku_id,
      sku.description as sku_description,
      billing_account_id,
      REPLACE(project.ancestors[SAFE_ORDINAL(ARRAY_LENGTH(project.ancestors))].resource_name,'organizations/', '') as organizationId,
      project.ancestors[SAFE_ORDINAL(ARRAY_LENGTH(project.ancestors))].display_name as organizationName,
      project.id as projectId,
      project.name as projectName,
      net_cost,
      invoice.month as invoice_month,
      usage.pricing_unit as pricing_unit,
      usage.amount_in_pricing_units as amount_in_pricing_units
    FROM {{ source('src_billboard', 'billboard') }}
  )

select
      date,
      service_id,
      service_description,
      sku_id,
      sku_description,
      billing_account_id,
      organizationId,
      organizationName,
      projectId,
      projectName,
      invoice_month,
      pricing_unit,
sum(amount_in_pricing_units) as amount_in_pricing_units,
sum(net_cost) as net_cost

from data

group by
  date,
  service_id,
  service_description,
  sku_id,
  sku_description,
  billing_account_id,
  organizationId,
  organizationName,
  projectId,
  projectName,
  invoice_month,
  pricing_unit