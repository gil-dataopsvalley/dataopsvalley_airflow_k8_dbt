select distinct
    FormName,
    id,
    Age,
    AgeGroup,
    birthYear,
    --EXTRACT(YEAR FROM CURRENT_DATE) - cast(birthYear as int64) -1 as age,
    gender_dataCode,
    gender_dataText,
    {{ isnull_string_to_int('fromCity_dataCode') }} as fromCity_dataCode,
    {{ isnull_he_string('fromCity_dataText') }} as fromCity_dataText,
    quest_home_dataCode,
    quest_home_dataText,
    {{ isnull_string_to_int('newRomCity_dataCode') }} as newRomCity_dataCode,
    {{ isnull_he_string('newRomCity_dataText') }} as newRomCity_dataText,
    dateHome,
    shelterType_dataCode,
    shelterType_dataText,

    case shelterType_dataCode
        when '1' then 'מוסדר'
        when '2' then 'לא מוסדר'
        when '3' then 'אחר'
        else 'לא ידוע'
    end as shelterType,

    shelterName_dataCode,
    shelterName_dataText,
    shelterNameElse,
    bankAccount_dataCode,
    bankAccount_dataText,
    ifPregnant_dataCode,
    ifPregnant_dataText,
    ifAccessible_dataCode,
    ifAccessible_dataText,

    case
        when {{ isnull_string_to_int('shelterCity_dataCode') }}  <> -1
            then {{ isnull_string_to_int('shelterCity_dataCode') }}
        else {{ isnull_string_to_int('privateShelterCity_dataCode') }}
    end as shelterCityUnion_Code,
    privateShelterStreet_dataCode,
    privateShelterStreet_dataText,
    privateShelterHouseNum,
    hasAnotherFamily_dataCode,
    hasAnotherFamily_dataText,
    commitment,
    referenceNumber,
    parse_datetime('%d/%m/%Y %H:%M:%S', sentDate) as sentDateTime,
    date(parse_datetime('%d/%m/%Y %H:%M:%S', sentDate)) as sentDate,
    FileName

from {{ source('src_evc', 'MRR_Evc_Ironswords_Roots') }}
