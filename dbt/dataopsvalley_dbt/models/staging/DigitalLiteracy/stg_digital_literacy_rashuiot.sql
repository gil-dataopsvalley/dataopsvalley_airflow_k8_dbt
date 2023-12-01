select
    key,
    he,
    en,
    ar,
    region

FROM {{ source('src_digital_literacy', 'MRR_DigitalLiteracy_Rashuiot') }}