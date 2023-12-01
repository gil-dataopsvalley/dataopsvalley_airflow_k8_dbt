select
    SupplierID,
    SupplierName

from {{ ref('stg_digital_literacy_supplier') }}