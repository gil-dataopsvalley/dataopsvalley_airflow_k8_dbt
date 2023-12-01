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
    roots.shelterCityUnion_Code,
    city.SettelmentName as shelterCityUnion_Name,
    roots.shelterType,
    roots.shelterName_dataText,
    roots.shelterNameElse,
    roots.bankAccount_dataText,
    roots.ifPregnant_dataText,
    roots.ifAccessible_dataText,
    roots.hasAnotherFamily_dataText,
    roots.sentDate,
    roots.sentDateTime,
    roots.FileName

from {{ ref('stg_evc_ironswords_roots') }} roots
left join {{ ref('DWH_DIM_Evc_TownsPopulation') }} city
on roots.shelterCityUnion_Code = city.SettelmentSymbolNumber