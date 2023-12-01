
select
    Cluster,
    Office,
    VMName,
    VMHostName,
    RAM,
    CPU,
    PowerStatus,
    OS,
    HD_Actual,
    LastUpdate

from {{ ref('stg_ITServer') }}