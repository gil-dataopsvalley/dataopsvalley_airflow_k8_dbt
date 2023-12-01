select
    Field,
    Value,
    Value2,
    Title,
    Comments,
    DashboardName,
    Module,
    Sort
from {{ ref('stg_emun_single_data_table') }}

