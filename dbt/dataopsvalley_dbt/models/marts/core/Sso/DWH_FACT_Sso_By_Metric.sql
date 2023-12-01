select
    Date,
    Message,
    MetricName,
    CntDaily

from {{ ref('stg_sso_by_metric') }}