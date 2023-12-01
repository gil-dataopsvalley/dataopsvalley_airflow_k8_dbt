select
  filename,
  tools_or_assistance,
  used_or_not_used

from {{ ref('stg_ncc_project_assistance')}}
