select  referenceNumber,
        sentDate,
        sentDateTime,
        'Submitter' as SubmitterOrAccompany,
        'מגיש' as accompanyingRelation,
        'מספר זהות' as identify_type,
        id,
        birthYear,
        age,
        AgeGroup,
        case when AgeGroup = '0 - 18' then 'Child' else 'Adult' end as Child_Adult,
        gender_dataText as gender,
        fromCity_dataText,
        fromCity_dataCode,

        case    when newRomCity_dataText <> 'לא ידוע' then newRomCity_dataText
                else fromCity_dataText end as fromCityUnion,

        case    when newRomCity_dataCode <> -1 then newRomCity_dataCode
                else fromCity_dataCode end as fromCityUnion_code,

        cast(FORMAT_DATE('%F', DATE(cast(SPLIT(dateHome, '/')[ORDINAL(3)] as int),
                                    cast(SPLIT(dateHome, '/')[ORDINAL(2)] as int),
                                    cast(SPLIT(dateHome, '/')[ORDINAL(1)] as int))) as DATE) as dateHome,

        shelterCityUnion_Code,
        shelterCityUnion_Name,
        shelterType,
        shelterName_dataText as shelterName,
        shelterNameElse,
        NULL as detail, -- פירוט מקלט מסוג אחר - השדה מופיע רק לנלווה
        bankAccount_dataText as bankAccount,
        ifPregnant_dataText as ifPregnant,
        ifAccessible_dataText as ifAccessible

FROM {{ ref('stg_evc_ironswords_roots_city_name') }}
where id <> 0

union all

select  referenceNumber,
        sentDate,
        sentDateTime,
        'Accompany' as SubmitterOrAccompany,
        accompanyingRelation_dataText as accompanyingRelation,
        identify_dataText as identify_type,
        COALESCE(accompanyingId, foreignPassport) as id, -- אם יש מספר זהות תשתמש בו, אחרת אם יש מספר דרכון תשתמש בו
        birthYearF as birthYear,
        accompanyAge as age,
        accompanyAgeGroup as AgeGroup,
        case when accompanyAgeGroup = '0 - 18' then 'Child' else 'Adult' end as Child_Adult,
        genderF_dataText as gender,
        fromCity_dataText,
        fromCity_dataCode,

        case    when newRomCity_dataText <> 'לא ידוע' then newRomCity_dataText
                else fromCity_dataText end as fromCityUnion,

        case    when newRomCity_dataCode <> -1 then newRomCity_dataCode
                else fromCity_dataCode end as fromCityUnion_code,

        cast(FORMAT_DATE('%F', DATE(cast(SPLIT(dateHome, '/')[ORDINAL(3)] as int),
                                    cast(SPLIT(dateHome, '/')[ORDINAL(2)] as int),
                                    cast(SPLIT(dateHome, '/')[ORDINAL(1)] as int))) as DATE) as dateHome,

        case place_dataText when 'כן' then shelterCityUnion_Code
                            when 'לא' then accompanyingShelterCityUnion_Code end as shelterCityUnion_Code,

        case place_dataText when 'כן' then shelterCityUnion_Name
                            when 'לא' then accompanyingShelterCityUnion_Name end as shelterCityUnion_Name,

        case place_dataText when 'כן' then shelterType
--                            when 'לא' then  accompanyingShelterType
                            when 'לא' then case accompanyingShelterType_dataCode
                                            when '1' then 'מוסדר'
                                            when '2' then 'לא מוסדר'
                                            when '3' then 'אחר'
                                            else 'לא ידוע' end
                            end as shelterType,

        case place_dataText when 'כן' then shelterName_dataText
                            when 'לא' then accompanyingShelterName_dataText end as shelterName,

        case place_dataText when 'כן' then shelterNameElse
                            when 'לא' then accompanyingShelterElse end as shelterNameElse,
        detail, -- פירוט מקלט מסוג אחר - השדה מופיע רק לנלווה
        NULL as bankAccount, -- זה שייך רק למגיש
        NULL as ifPregnant, -- נראה שייך רק למגיש, אבל זה אפילו לא מופיע בטופס!
        NULL as ifAccessible -- זה כן מופיע בטופס גם לנלווה וגם למגיש (כאשר שניהם במקלט מוסדר) אבל לא מופיע בבסיס הנתונים עבור הנלווה

FROM {{ ref('stg_evc_ironswords_joined') }}

where accompanyingRelation_dataText is not null
and id <> 0
