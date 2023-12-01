
select
    project_id,
    user_type,
    user_and_serviceAccount_and_group as groupName,
    role,
    uploaded_date

from {{ ref('stg_gcp_all_types_users') }}

where user_type = 'group'