select
      office_name,
      {{ isnull_he_string('size') }} as office_size

from {{ source('src_ncc', 'MRR_Ncc_SizeOffice')}}
