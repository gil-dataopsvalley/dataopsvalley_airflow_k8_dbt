
select
        project_id,
        case
            when user like '%serviceAccount:%' then 'serviceAccount'
            when user like '%user:%' then 'user'
            when user like '%group:%' then 'group'
            else 'ZZZZ'
        end as user_type ,
        case
            when user like '%serviceAccount:%' then replace(user,'serviceAccount:','')
            when user like '%user:%' then replace(user,'user:','')
            when user like '%group:%' then replace(user,'group:','')
            else 'ZZZZ'
        end as user_and_serviceAccount_and_group,
        role,
        uploaded_date

from {{ source('src_gcp_users', 'MRR_ProjectGCP_Roles_and_Users') }}