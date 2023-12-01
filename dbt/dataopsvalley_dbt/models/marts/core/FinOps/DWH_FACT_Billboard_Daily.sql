
{{
   config
    (
        unique_key='id'
    )
}}

select
      {{ dbt_utils.generate_surrogate_key([
        'date',
        'invoiceMonth',
        'project_id',
        'service_description',
        'sku_id',
        'sku_description'])}} as id,
      date,
      service_id,
      service_description,
      sku_id,
      sku_description,
      net_cost,
      pricing_unit,
      amount_in_pricing_units,
      invoiceMonth,
      project_id,
      organization_id,
      organization_name,
      project_status,
      department,
      owner_email,
      environment,
      product_name,
      merkava_purchase_order_number,
      merkava_ministry_id,
      ministry_name,
      account_name,
      owner_contact,
      product_manager_name,
      Mobile

from {{ ref('stg_billboard_daily_gcp_metadata') }}
