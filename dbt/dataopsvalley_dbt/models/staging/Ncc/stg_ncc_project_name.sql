select
      filename,
      name_of_the_office as office_name,
      project_name

from {{ source('src_ncc', 'MRR_Ncc_ProjectName')}}
