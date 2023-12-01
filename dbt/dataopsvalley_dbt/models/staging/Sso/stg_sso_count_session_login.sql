select
    cast(Date as Date) as Date,
    {{ isnull_int('cast(count_succes as int)') }} as CountSucces,
    {{ isnull_int('cast(count_fail as int)') }} as CountFail,
    {{ isnull_int('cast(sum_count_session_id as int)') }} as SumCountSessionId,
    CntDaily

from {{ source('src_sso_count_session_login', 'MRR_SSO_count_session_login') }}