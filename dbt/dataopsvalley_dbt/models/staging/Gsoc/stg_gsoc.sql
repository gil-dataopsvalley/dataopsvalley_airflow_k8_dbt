select
    union_data.Platform,
    union_data.Datetime,
--    REPLACE(STRING_AGG(CAST(union_data.GroupName AS STRING), ';'), ';', chr(10)) as GroupName,
--    ARRAY_AGG(union_data.GroupName) as GroupName,
    union_data.GroupName as GroupName,
    union_data.KeyWord,
    union_data.Severity,
    union_data.Message,
--    ARRAY_AGG(union_data.Link) as Link,
    union_data.Link as Link,
    dates.WeekDay
from {{ ref('stg_gsoc_union_telebot_clearnet_darknet') }} as union_data
inner join {{ ref('DWH_DIM_Date') }} as dates
on cast(split(cast(Datetime as string), ' ')[ORDINAL(1)] as Date)  = dates.DateFull