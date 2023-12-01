select
    employment_branch,
    cast(total_claims as INT) as total_claims,
    cast(replace(the_percentage_of_claims_out_of_total, '%', '') as FLOAT64) as percentage_of_claims

from {{ source('src_emun', 'MRR_Emun_UnemploymentJobClaimsByBranches') }}