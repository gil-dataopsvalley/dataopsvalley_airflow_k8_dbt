select
    Platform,
    Datetime,
    NumOfGroups,
    GroupNames,
    Link,
    KeyWord,
    Severity,
    Message,
    TranslatedMessage,
    SourceLanguage,
    WeekDay,
    IsCurrentDay

from {{ ref('stg_gsoc_message') }}
