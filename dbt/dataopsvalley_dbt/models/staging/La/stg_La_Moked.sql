{#
select
    cast(FORMAT_DATE('%F', DATE(cast(SPLIT(Date, '/')[ORDINAL(3)] as int),
                                cast(SPLIT(Date, '/')[ORDINAL(2)] as int),
                                cast(SPLIT(Date, '/')[ORDINAL(1)] as int))) as DATE) as Date,
    Local_authority_name,
    Domain,
    Sub_domain,
    CAST(REPLACE(Count_daily, ',', '') AS FLOAT64) as Count_daily

FROM {{ source('src_la_Moked', 'MRR_LA_Moked') }}
#}