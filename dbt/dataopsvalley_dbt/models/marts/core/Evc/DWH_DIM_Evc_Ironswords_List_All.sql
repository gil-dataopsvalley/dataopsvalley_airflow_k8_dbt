{{
   config
    (
        unique_key='id_key'
    )
}}

select
      {{ dbt_utils.generate_surrogate_key([
        'referenceNumber',
        'id'])}} as id_key,

    referenceNumber,
    sentDate,
    sentDateTime,
    SubmitterOrAccompany,
    accompanyingRelation,
    identify_type,
    id,
    birthYear,
    age,
    AgeGroup,
    Child_Adult,
    gender,
    fromCity_dataText as fromCity,
    fromCity_dataCode as fromCity_code,
    fromCityUnion,
    fromCityUnion_code,
    dateHome,
    shelterCityUnion_Code,
    shelterCityUnion_Name,
    shelterType,
    shelterName,
    shelterNameElse,
    detail,
    bankAccount,
    ifPregnant,
    ifAccessible,
    city.EvacuationDate,
    city.Distance,

FROM {{ ref('stg_evc_ironswords_list_all') }} la
LEFT JOIN {{ ref('DWH_DIM_Evc_TownsPopulation') }} city
on la.fromCityUnion_code = city.SettelmentSymbolNumber


