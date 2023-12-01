select
  office_name,
  project_name,
  a_major_challenge,
  sub_challenge,
  sub_sub_challenge,
  what_is_taken_into_account,
  exists__v__or_does_not_exist__blank_ as present__v__not_present__blank_

from {{ source('src_ncc', 'MRR_Ncc_projectDetail')}}
