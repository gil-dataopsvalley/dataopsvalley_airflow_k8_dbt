
select
    accountid as CustomerCRMCode,
    name as CustomerName,
    statuscode as StatusCode,
    statuscodename as StatusCodeName,
    {{ isnull_en_string('emailaddress1') }} as Email,
    statecode as StateCode,
    statecodename as StateName,
    {{ isnull_en_string('telephone1') }} as Telephone,
    {{ isnull_en_string('websiteurl') }} as WebSiteUrl,
    yuval_lp_accountid as ParentCustomerCRMCode,
    {{ isnull_he_string('yuval_lp_accountidname') }} as ParentCustomerName,
    {{ isnull_he_string('yuval_lp_cioidname') }} as ManmarContactName,
    {{ isnull_en_string('yuval_lp_foundation_pm_systemuseridname') }} as ManapHakamaSystemUserName,
    {{ isnull_en_string('yuval_lp_gov_site_managername') }} as SiteManagerSystemUserName,
    {{ isnull_he_string('yuval_lp_it_maneger_systemuseridname') }} as ManapITSystemUserName,
    {{ isnull_he_string('yuval_lp_maintenance_pm_systemuseridname') }} as ManapTachzukaSystemUserName,
    {{ isnull_int('yuval_pl_level') }} as LevelId,
    {{ isnull_en_string('yuval_pl_levelname') }} as LevelIdName,
    {{ isnull_en_string('yuval_s_domain') }} as Domain,
    --current_datetime('Asia/Jerusalem') as UpdateDate
    {{ isCurrentDay() }} as LastUpdate

from {{ source('yuval_customer', 'MRR_YuvalAccount') }}
where statecode = 0

union all -- Adding unknown value record
select
    "CFD15631-830B-447C-B5AF-C6D639CF2F1C" as CustomerCRMCode,
    "לא ידוע" as CustomerName,
    1 as StatusCode,
    "לא ידוע" as StatusCodeName,
    "לא ידוע" as Email,
    0 as StateCode,
    "לא ידוע" as StateName,
    "לא ידוע" as Telephone,
    "לא ידוע" as WebSiteUrl,
    "CFD15631-830B-447C-B5AF-C6D639CF2F1C" as ParentCustomerCRMCode,
    "לא ידוע" as ParentCustomerName,
    "לא ידוע" as ManmarContactName,
    "לא ידוע" as ManapHakamaSystemUserName,
    "לא ידוע" as SiteManagerSystemUserName,
    "לא ידוע" as ManapITSystemUserName,
    "לא ידוע" as ManapTachzukaSystemUserName,
    -1 as LevelId,
    "לא ידוע" as LevelIdName,
    "לא ידוע" as Domain,
    current_datetime('Asia/Jerusalem') as UpdateDate