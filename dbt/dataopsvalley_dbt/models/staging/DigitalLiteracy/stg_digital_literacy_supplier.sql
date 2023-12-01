select
    SupplierID,
    SupplierName

FROM {{ source('src_digital_literacy', 'MRR_DigitalLiteracy_Suppliers') }}