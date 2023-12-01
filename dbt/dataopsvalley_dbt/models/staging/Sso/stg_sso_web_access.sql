select
    cast(Date as Date) as Date,
    {{ isnull_en_string('accessed_url') }} as AccessedUrl,
    {{ isnull_en_string('message') }} as Message,
    {{ isnull_en_string('application_name') }} as ApplicationName,
    {{ isnull_he_string('dns.customer') }} as CustomerName,
    {{ isnull_guid('cus.CustomerCRMCode') }} as CustomerCRMCode,
    {{ isnull_int('cast(dns.StatusCode as int)') }} as StatusCode,
    {{ isnull_he_string('dns.DnsSite') }} as DnsSite,
    CntDaily

from {{ source('src_sso_web_access', 'MRR_SSO_Web_Access') }} wac
inner join {{ source('src_sso_yuval_dns', 'MRR_SSO_Yuval_Dns') }} dns
on wac.accessed_url = dns.DnsUrl
left join {{ ref('DWH_DIM_YuvalCustomer') }} cus
on dns.customer = cus.CustomerName