select distinct
    FormName,
    _ParentKeyField,
    accompanyingRelation_dataCode,
    accompanyingRelation_dataText,
    identify_dataCode,
    identify_dataText,
    accompanyingId,
    foreignPassport,
    Age,
    AgeGroup,
    birthYearF,
    genderF_dataCode,
    genderF_dataText,
    place_dataCode,
    place_dataText,
    accompanyingShelterType_dataCode,
--    accompanyingShelterType_dataText,
    detail,
    accompanyingShelterCity_dataCode,
    -- accompanyingShelterCity_dataText
    accompanyingPrivateShelterCity_dataCode,
    -- accompanyingPrivateShelterCity_dataText

    case
        when {{ isnull_string_to_int('accompanyingShelterCity_dataCode') }} <> -1
            then {{ isnull_string_to_int('accompanyingShelterCity_dataCode') }}
        else {{ isnull_string_to_int('accompanyingPrivateShelterCity_dataCode') }}
    end as accompanyingShelterCityUnion_Code,

    accompanyingShelterName_dataCode,
    accompanyingShelterName_dataText,
    accompanyingShelterElse,
    FileName

from {{ source('src_evc', 'MRR_Evc_Ironswords_relativeRList') }}


