select
    Date,
    CountSucces,
    CountFail,
    SumCountSessionId,
    CntDaily

from {{ ref('stg_sso_count_session_login') }}