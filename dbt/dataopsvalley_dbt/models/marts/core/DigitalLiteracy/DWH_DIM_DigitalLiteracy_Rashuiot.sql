select
    key,
    he,
    en,
    ar,
    region

from {{ ref('stg_digital_literacy_rashuiot') }}