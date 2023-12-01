select
  roots.referenceNumber,
  roots.id,
  roots.age,
  roots.AgeGroup,
  roots.birthYear,
  roots.gender_dataText,
  roots.fromCity_dataCode,
  roots.fromCity_dataText,
  roots.quest_home_dataText,
  roots.newRomCity_dataCode,
  roots.newRomCity_dataText,
  roots.dateHome,
  roots.shelterCityUnion_Name,
  roots.shelterCityUnion_Code,
  roots.shelterType,
  roots.shelterName_dataText,
  roots.shelterNameElse,
  roots.bankAccount_dataText,
  roots.ifPregnant_dataText,
  roots.ifAccessible_dataText,
  roots.hasAnotherFamily_dataText,
  roots.sentDate,
  roots.sentDateTime,

  relatives.accompanyingRelation_dataText,
  relatives.identify_dataText,
  relatives.accompanyingId,
  relatives.foreignPassport,
  relatives.accompanyAge,
  relatives.accompanyAgeGroup,
  relatives.birthYearF,
  relatives.genderF_dataText,
  relatives.place_dataText,
  relatives.detail,
  relatives.accompanyingShelterCityUnion_Code,
  relatives.accompanyingShelterCityUnion_Name,
  relatives.accompanyingShelterType_dataCode,

  relatives.accompanyingShelterName_dataText,
  relatives.accompanyingShelterElse


FROM {{ ref('stg_evc_ironswords_roots_city_name') }} roots
LEFT JOIN {{ ref('stg_evc_ironswords_relatives_city_name') }} relatives
    on roots.FileName = relatives.FileName
