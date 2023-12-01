select
    Date,
    Local_authority_name,
    Domain,
    Sub_domain,
    Count_daily

FROM {{ ref('stg_La_Moked') }}