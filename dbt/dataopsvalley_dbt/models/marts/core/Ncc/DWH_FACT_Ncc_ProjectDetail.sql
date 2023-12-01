select
  office_name,
  project_name,
  a_major_challenge,
  sub_challenge,
  sub_sub_challenge,
  what_is_taken_into_account,
  present__v__not_present__blank_

from {{ ref('stg_ncc_project_detail')}}
