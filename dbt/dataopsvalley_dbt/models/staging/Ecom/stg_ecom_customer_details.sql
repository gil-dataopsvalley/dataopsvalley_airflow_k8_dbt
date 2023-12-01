
with ecomCustomerDetails
as
( SELECT
    e.officeId as officeId_Ecom,
    b.CustomerCRMCode,
    FROM {{ source('src_ecom', 'MRR_Ecom_v_ecom') }} as e
    LEFT JOIN {{ source('src_brg_ecom_customer', 'DWH_BRG_Ecom_Customer') }} as b
      on cast(e.officeId as int) = b.CustomerPayCode

)

select distinct
 officeId_Ecom,
 cte.CustomerCRMCode,
 c.CustomerName,
 c.Domain

from ecomCustomerDetails as cte
inner join {{ ref('DWH_DIM_YuvalCustomer')}} as c
  on lower(cte.CustomerCRMCode) = lower(c.CustomerCRMCode)