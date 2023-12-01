select
    id,
    immigrationYear_dataText as immigrationYear,
    originCountry,
    translationAssistance,
    language,
    economicHardship,
    detail,
    employment,
    workplace,
    halat,
    case
        when workplace = 'כן' then 'ממשיך לעבוד'
        when workplace = 'לא' and halat = 'כן' then 'לא עובד - חל"ת'
        when workplace = 'לא' and halat = 'לא' then 'לא עובד - אין חל"ת'
        when workplace = 'לא' and (halat not in ('כן','לא') or halat is null) then 'לא עובד - חל"ת לא ידוע'
        else 'לא ידוע' end  as sachir_union_for_graph,
    activeBusiness,
    detailActive,
    getToBusiness,
    case
        when activeBusiness = 'לא' then 'עסק לא פעיל'
        when activeBusiness = 'כן' and getToBusiness = 'לא' then 'עסק פעיל ולא נדרש להגיע אליו'
        when activeBusiness = 'כן' and getToBusiness = 'כן' then 'עסק פעיל ונדרש להגיע אליו'
        when activeBusiness = 'כן' and (getToBusiness not in ('כן','לא') or getToBusiness is null) then 'עסק פעיל - הגעה לא ידועה'
        else 'לא ידוע' end  as atzmai_union_for_graph,
    appliedBefore,
    appliedAnser as appliedAnswer,
    case
        when appliedBefore = 'לא' then 'לא פנו'
        when appliedBefore = 'כן' and appliedAnser = 'כן' then 'קיבלו מענה'
        when appliedBefore = 'כן' and appliedAnser = 'לא' then 'לא קיבלו מענה'
        when appliedBefore = 'כן' and (appliedAnser not in ('כן','לא') or appliedAnser is null) then 'מענה לא ידוע'
        else 'לא ידוע' end  as applied_union_for_graph,
    referenceNumber,
    parse_datetime('%d/%m/%Y %H:%M:%S', sentDate) as sentDateTime,
    date(parse_datetime('%d/%m/%Y %H:%M:%S', sentDate)) as sentDate,
    FileName

from {{ source('src_evc', 'MRR_Evc_ironswordsAbsorptionAndImmigration_Roots') }}
