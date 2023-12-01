select
    office_name,
    office_size,
    weighted_score,
    position_by_size,
    cluster_size,
    general_location,
    general_cluster

from {{ ref('stg_ncc_office_rating') }}