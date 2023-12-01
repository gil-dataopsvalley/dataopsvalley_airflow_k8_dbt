with General as (
    select distinct
    Domain,
    CustomerDesc,
    ComponentType,
    FactName,
    FactDescriptionHeb,
    Date
from {{ ref('stg_dynatrace') }}
)

select
    General.Domain,
    General.CustomerDesc,
    General.ComponentType,
    General.FactName,
    General.FactDescriptionHeb,
    General.Date,
    {{ castToInt('a.Value') }} as no_CompleteDownload,
    {{ castMicroSecondToSecond('b.Value') }}  as avg_ResponseTimeSeconds,
    {{ castToInt('c.Value') }} as no_Appear,
    {{ castToInt('d.Value') }} as no_Click,
    {{ castToInt('e.Value') }} as no_CompleteProcess,
    round(cast(f.Value as FLOAT64),2) as pct_Error
from General
Left join {{ ref('stg_dynatrace') }} as a
on General.FactName = a.FactName and General.Date = a.Date and a.MetricName = 'valCompleteDownload'
Left join {{ ref('stg_dynatrace') }} as b
on General.FactName = b.FactName and General.Date = b.Date and b.MetricName = 'valResponseTime'
Left join {{ ref('stg_dynatrace') }} as c
on General.FactName = c.FactName and General.Date = c.Date and c.MetricName = 'valAppear'
Left join {{ ref('stg_dynatrace') }} as d
on General.FactName = d.FactName and General.Date = d.Date and d.MetricName = 'valClick'
Left join {{ ref('stg_dynatrace') }} as e
on General.FactName = e.FactName and General.Date = e.Date and e.MetricName = 'valCompleteProcess'
Left join {{ ref('stg_dynatrace') }} as f
on General.FactName = f.FactName and General.Date = f.Date and f.MetricName = 'valError'












