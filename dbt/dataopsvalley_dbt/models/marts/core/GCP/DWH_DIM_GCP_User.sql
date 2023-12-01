
select
    metadata.project_id,
    metadata.user_type,
    metadata.user,
    metadata.role,
    metadata.uploaded_date,
    metadata.FirstName,
    metadata.LastName,
    metadata.Mobile,
    metadata.ContactEmail,
    customer.CustomerName

from {{ ref('stg_gcp_users') }} as metadata
left join {{ ref('DWH_DIM_YuvalCustomer') }} as customer
on UPPER(metadata.Domain) = UPPER(customer.Domain)