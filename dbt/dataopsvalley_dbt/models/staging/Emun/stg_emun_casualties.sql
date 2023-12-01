select
    {{ cast_dmy_string_date('date', '-') }} as date,
    cast(number_of_casualties as INT) as number_of_casualties
from {{ source('src_emun', 'MRR_Emun_Casualties') }}