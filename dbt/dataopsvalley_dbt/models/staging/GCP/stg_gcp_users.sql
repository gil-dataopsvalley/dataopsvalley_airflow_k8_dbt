
select
    all_users.project_id,
    all_users.user_type,
    all_users.user_and_serviceAccount_and_group as user,
    all_users.role,
    all_users.uploaded_date,
    contact.FirstName,
    contact.LastName,
    contact.Mobile,
    contact.ContactEmail,
    REGEXP_REPLACE(ContactEmail, r'^.*@|\.gov\.il$', '') as Domain

from {{ ref('stg_gcp_all_types_users') }} as all_users
left join {{ ref('DWH_DIM_YuvalContact') }} as contact
on all_users.user_and_serviceAccount_and_group = contact.ContactEmail
where user_type = 'user'