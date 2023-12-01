select
    LocalAuthority_Name,
    LocalAuthority_Code,
    Total_Injured,
    Total_Died,
    Hospitalized_Now
from {{ ref('stg_emun_casualties_by_local_authority') }}