select
    employment_branch,
    total_claims,
    percentage_of_claims
from {{ ref('stg_emun_unemployment_job_claims_by_branches') }}