select 
    Platform,
    Datetime,
    GroupName,
    KeyWord,
    Severity,
    TRIM(REGEXP_REPLACE(Message, R"\s+", " ")) as Message,
    Link,
    NULL as Title,
    CAST(NULL AS ARRAY<STRING>) as Related_Entities,
    NULL as Category,
    NULL as Credential_Details,
    WeekDay
from {{ ref('stg_gsoc') }}

union all

select
    Platform,
    Datetime,
    NULL as GroupName,
    NULL as KeyWord,
    Severity,
    TRIM(REGEXP_REPLACE(Message, R"\s+", " ")) as Message,
    NULL as Link,
    Date,
    Time,
    Title,
    Related_Entities,
    Category,
    Credential_Details,
    WeekDay,
    MonthDesc

from {{ ref('stg_gsoc_cyberint_credentials_exposed') }}
