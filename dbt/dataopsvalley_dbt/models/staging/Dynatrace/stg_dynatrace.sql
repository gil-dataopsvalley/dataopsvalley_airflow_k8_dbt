
select
    Domain,
    customerDesc as CustomerDesc,
    componentType as ComponentType,
    CustomerReportDescriptionHeb,
    general.MetricName,
    MetricDisplayName,
    FactDescriptionHeb,
    general.FactName,
    general.ComponentName,
    Date-1 as Date, -- Subtract one day. Dynatrace "bug" gives us value from the PREVIOUS day starting 3:00AM.
    Value

from {{ source('src_dynatrace', 'MRR_Dynatrace_General') }} as general
inner join {{ source('src_dynatrace', 'MRR_MetaDataDynatrace') }} as metadata
using (componentName)

