select
  layer,
  problem_description,
  the_names_of_the_offices as office_name
from {{ source('src_ncc', 'MRR_Ncc_projectControlsubChallenge')}}