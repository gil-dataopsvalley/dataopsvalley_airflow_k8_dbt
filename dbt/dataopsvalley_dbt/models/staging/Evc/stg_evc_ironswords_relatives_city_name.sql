select
  relatives.accompanyingRelation_dataText,
  relatives.identify_dataText,
  relatives.accompanyingId,
  relatives.foreignPassport,
  relatives.age as accompanyAge,
  relatives.AgeGroup as accompanyAgeGroup,
  relatives.birthYearF,
  relatives.genderF_dataText,
  relatives.place_dataText,
  relatives.detail,
  relatives.accompanyingShelterType_dataCode,
  relatives.accompanyingShelterCity_dataCode,
  relatives.accompanyingPrivateShelterCity_dataCode,
  relatives.accompanyingShelterCityUnion_Code,
  city.SettelmentName as accompanyingShelterCityUnion_Name,

  relatives.accompanyingShelterName_dataText,
  relatives.accompanyingShelterElse,
  relatives.FileName

from {{ ref('stg_evc_ironswords_relative_r_list') }} relatives
left join {{ ref('DWH_DIM_Evc_TownsPopulation') }} city
on relatives.accompanyingShelterCityUnion_Code = city.SettelmentSymbolNumber
