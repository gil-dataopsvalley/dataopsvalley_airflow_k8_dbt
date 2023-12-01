select
    PARSE_DATE('%d-%b-%Y', concat(date_of_submission, '-2023')) as date_of_submission,
    {{ isnull_string_to_int('involuntary_unpaid_leave') }} as involuntary_unpaid_leave,
    {{ isnull_string_to_int('other_reasons') }} as other_reasons,
    {{ isnull_string_to_int('total') }} as total

from {{ source('src_emun', 'MRR_Emun_Unemployment') }}
