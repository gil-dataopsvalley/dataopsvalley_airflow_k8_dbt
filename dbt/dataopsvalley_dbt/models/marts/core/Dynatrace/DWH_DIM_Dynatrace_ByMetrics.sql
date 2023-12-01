
select
    Domain,
    CustomerDesc,
    ComponentType,
    FactName,
    FactDescriptionHeb,
    Date,
    no_CompleteDownload,
    avg_ResponseTimeSeconds,
    no_Appear,
    no_Click,
    no_CompleteProcess,
    pct_Error

from {{ ref('stg_dynatrace_ByMetrics') }}
