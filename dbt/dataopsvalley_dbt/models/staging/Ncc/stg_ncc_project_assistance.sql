select
  filename,
  tools_or_assistance,
  used_or_not_used

from {{ source('src_ncc', 'MRR_Ncc_ProjectAssistance')}}
