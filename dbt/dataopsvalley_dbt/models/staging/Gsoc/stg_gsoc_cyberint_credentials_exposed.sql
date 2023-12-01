select
    Platform,
    cast(Datetime as datetime) as Datetime,
    Severity,
    Message,
    Date,
    Time,
    Title,
    Relaited_Entities as Related_Entities,
    Category,
    Credential_Details,
    Link,
    dates.WeekDay,
    dates.MonthDesc

from {{ source('src_gsoc_cyberint_credentials_exposed', 'MRR_Gsoc_Cyberint_Credentials_Exposed') }}
inner join {{ ref('DWH_DIM_Date') }} as dates
on Date  = dates.DateFull