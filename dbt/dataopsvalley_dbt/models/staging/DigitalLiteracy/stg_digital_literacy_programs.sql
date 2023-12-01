select
    ProgramName,
    ProgramID

FROM {{ source('src_digital_literacy', 'MRR_DigitalLiteracy_Programs') }}