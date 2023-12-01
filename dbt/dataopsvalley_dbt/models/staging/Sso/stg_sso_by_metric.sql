select
    case when REGEXP_CONTAINS(Date, r'^[0-9]{4}[/\-][0-9]{2}[/\-][0-9]{2}$')
            then cast(Date as Date)
         else cast(FORMAT_DATE('%F', DATE(cast(SPLIT(Date, '-')[ORDINAL(3)] as int),
                           cast(SPLIT(Date, '-')[ORDINAL(2)] as int),
                           cast(SPLIT(Date, '-')[ORDINAL(1)] as int))) as Date)
    end as Date,
    {{ isnull_en_string('message') }} as Message,
    {{ isnull_en_string('MetricName') }} as MetricName,
    CntDaily

from {{ source('src_sso_by_metric', 'MRR_SSO_ByMetric') }}