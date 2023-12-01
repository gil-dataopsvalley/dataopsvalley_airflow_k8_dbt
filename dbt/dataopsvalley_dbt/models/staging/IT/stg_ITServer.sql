
select
    Office,
    Cluster,
    VMName,
    VMHostName,
    cast( RAM as NUMERIC) as RAM,
    cast( CPU as NUMERIC) as CPU,
    PowerStatus,
    OS,
    HD_Actual,
    {{ isCurrentDay() }} as LastUpdate

from {{ source('src_IT', 'MRR_Servernew') }} as a

