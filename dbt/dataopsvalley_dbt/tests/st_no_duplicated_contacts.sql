{{ config(
    store_failures = true,
    schema = "_Test_failures_schema"
) }}

with source_contacts_count as (

select count(*) as source_contacts_count
from {{ source('src_yuval_contact', 'MRR_YuvalContact') }}
where stateCode = 0
),

final_contacts_count as (

select count(*) final_contacts_count
from {{ ref('DWH_DIM_YuvalContact') }}
)

select current_date() as date,
       current_timestamp() as datetime,
       'fail' as status,
       abs(scc.source_contacts_count - fcc.final_contacts_count) as numOfRecords,
from source_contacts_count as scc, final_contacts_count as fcc
where scc.source_contacts_count <> fcc.final_contacts_count