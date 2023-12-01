select
    name_of_the_office as office_name,
    trim(the_size_of_the_office) as office_size,
    weighted_score, --ציון משוקלל
    position_by_size, -- מיקום לפי גודל
    cluster_size, -- מקבץ גודל
    general_location, -- מיקום כללי
    general_cluster --מקבץ כללי

from {{ source('src_ncc', 'MRR_Ncc_Office_Rating') }}