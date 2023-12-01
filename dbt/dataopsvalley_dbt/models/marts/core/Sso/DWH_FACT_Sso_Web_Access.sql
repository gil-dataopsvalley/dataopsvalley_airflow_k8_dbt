select
    Date,
    AccessedUrl,
    Message,
    ApplicationName,
    CustomerName,
    CustomerCRMCode,
    StatusCode,
    DnsSite,
    CntDaily

from {{ ref('stg_sso_web_access') }}