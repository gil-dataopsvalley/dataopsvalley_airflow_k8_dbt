
select
    Cluster,
    b.Yuval_Customer as Office,
    VMName,
    VMHostName,
    cast( RAM as NUMERIC) as RAM,
    cast( CPU as NUMERIC) as CPU,
    PowerStatus,
    OS,
    HD_Actual,
    {{ isCurrentDay() }} as LastUpdate

from {{ source('src_IT', 'MRR_Servernew') }} as a
inner join {{ source('src_IT', 'MRR_MappingITServerCustomerToYuval') }} as b
on a.Office = b.IT_Server

