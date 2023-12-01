with latest as
(   select  id,
            max(sentDateTime) as latest_sentDateTime

    FROM {{ ref('stg_evc_ironswords_list_all') }}

    group by id
)

select list.*

FROM {{ ref('stg_evc_ironswords_list_all') }} list
INNER JOIN latest
    on latest.id = list.id
    and latest.latest_sentDateTime = list.sentDateTime
