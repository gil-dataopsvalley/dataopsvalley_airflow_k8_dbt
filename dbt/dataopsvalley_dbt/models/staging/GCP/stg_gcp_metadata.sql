
select
  project_id,
  replace(project_name, "projects/", "") as project_number,
  project_status,
  project_labels.department as department,
  project_labels.owners_group_email as owners_group_email,
  project_labels.environment as environment,
  project_labels.product_name as product_name,
  project_labels.merkava_purchase_order_number as merkava_purchase_order_number,
  project_labels.merkava_ministry_id as merkava_ministry_id,
  project_labels.ministry_name as ministry_name,
  project_labels.account_name as account_name,
  project_labels.owner_contact as owner_contact

from {{ source('src_gcp_metadata', 'MRR_ProjectGCP_Metadata') }}