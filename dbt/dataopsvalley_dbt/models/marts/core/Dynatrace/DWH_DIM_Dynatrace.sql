
select
    Domain,
    CustomerDesc,
    ComponentType,
    CustomerReportDescriptionHeb,
    MetricName,
    MetricDisplayName,
    FactDescriptionHeb,
    FactName,
    ComponentName,
    Date,
    Value

from {{ ref('stg_dynatrace') }}