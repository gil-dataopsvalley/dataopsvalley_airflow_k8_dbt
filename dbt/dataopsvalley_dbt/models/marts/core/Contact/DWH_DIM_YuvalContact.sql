
select
    FirstName,
    LastName,
    Mobile,
    ContactEmail,
    CustomerCRMCode,
    LastUpdate

from {{ ref('stg_yuval_contact') }}