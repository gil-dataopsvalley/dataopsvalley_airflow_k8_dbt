select
    Field,
    Value,
    Value2,
    concat(Field, ' ' , IFNULL(Value2, '')) as Title,
    Comments,
    DashboardName,
    Module,
    cast(Sort as int) as Sort
from {{ source('src_emun', 'MRR_Emun_SingleDataTable') }}