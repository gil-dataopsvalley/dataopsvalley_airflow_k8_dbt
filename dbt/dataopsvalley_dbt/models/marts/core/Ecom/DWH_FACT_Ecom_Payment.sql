select
    CustomerCRMCode,
    CustomerName,
    Domain,
    Organization,
    PaymentsCount,
    PaymentsSum,
    DateLastChanged,
    ServiceCode,
    OfficeIdEcom,
    OfficeNameEcom,
    TransactionType,
    StationId,
    PayMethodCode,
    PayMethodDesc,
    PayMethodCategory,
    OneclickPayMethod,
    CcMutag,
    CommerceName,
    ServiceDesc

from {{ ref('stg_ecom_payment') }}
where DateLastChanged < current_date()