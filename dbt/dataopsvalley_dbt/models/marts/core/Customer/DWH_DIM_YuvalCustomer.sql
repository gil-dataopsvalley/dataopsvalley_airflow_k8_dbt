
select
    CustomerCRMCode,
    CustomerName,
    StatusCode,
    StatusCodeName,
    Email,
    StateCode,
    StateName,
    Telephone,
    WebSiteUrl,
    ParentCustomerCRMCode,
    ParentCustomerName,
    ManmarContactName,
    ManapHakamaSystemUserName,
    SiteManagerSystemUserName,
    ManapITSystemUserName,
    ManapTachzukaSystemUserName,
    LevelId,
    LevelIdName,
    Domain,
    LastUpdate

from {{ ref('stg_yuval_customer') }}