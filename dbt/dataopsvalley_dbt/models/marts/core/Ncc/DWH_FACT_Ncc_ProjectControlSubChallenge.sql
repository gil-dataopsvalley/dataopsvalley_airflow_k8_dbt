select
  layer,
  problem_description,
  office_name

from {{ ref('stg_ncc_projectControlSubChallenge')}}