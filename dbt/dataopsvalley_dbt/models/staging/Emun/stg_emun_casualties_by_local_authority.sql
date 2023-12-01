select
    LocalAuthority_Name,
    LocalAuthority_Code,
    Total_Injured,
    Total_Died,
    Hospitalized_Now
from {{ source('src_emun', 'MRR_Emun_CasualtiesByLocalAuthority') }}