select
    Platform,
    Datetime,
    GroupName,
    KeyWord,
    Severity,
    Message,
    Title,
    Related_Entities,
    Category,
    Credential_Details,
    Link,
    WeekDay
from {{ ref('stg_gsoc_full_data') }}