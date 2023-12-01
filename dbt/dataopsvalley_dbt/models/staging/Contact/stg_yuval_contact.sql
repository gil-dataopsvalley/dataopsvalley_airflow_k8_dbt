
select
    {{ isnull_guid('yuval_pl_major_accountid') }} as CustomerCRMCode,
    {{ isnull_he_string('firstname') }} as FirstName,
    {{ isnull_he_string('lastname') }} as LastName,
    {{ isnull_en_string('yuval_s_mobile') }} as Mobile,
    {{ isnull_en_string('emailaddress1') }} as ContactEmail,
    {{ isCurrentDay() }} as LastUpdate

from {{ source('src_yuval_contact', 'MRR_YuvalContact') }}

where statecode = 0 -- Only active records


