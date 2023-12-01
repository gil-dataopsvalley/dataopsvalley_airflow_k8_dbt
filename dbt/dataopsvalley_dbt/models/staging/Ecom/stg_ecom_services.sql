with ranked_services as (
    select
        ServiceCode,
        REGEXP_REPLACE(ServiceDesc, r'\([^)]*\)', '') as ServiceDesc,
        case
        when TypeService = 'Counter' then 'Counter_commerce'
        when TypeService = 'Voucher' then 'Voucher_commerce'
        when TypeService = 'PaymentService' then 'Payment_service'
        else TypeService end
        as CommerceName,

        -- Deduplicating. See documentation in YML file
        ROW_NUMBER() OVER (PARTITION BY ServiceCode,TypeService) AS RankBy_ServiceCodeAndTypeService

    from {{ source('src_ecom_services', 'MRR_Ecom_Services') }}
    )


select
  ServiceCode,
  CommerceName,
  ServiceDesc
from ranked_services
where RankBy_ServiceCodeAndTypeService = 1

