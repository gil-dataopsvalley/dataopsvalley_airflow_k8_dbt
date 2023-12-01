select
    sel.LanguageId,
    lang.DisplayName as ServiceLanguage,
    sel.ServiceIndex

from {{ source('src_kiosk_service_language', 'MRR_Kiosk_ServiceLanguage') }} sel
left join {{ source('src_kiosk_language', 'MRR_Kiosk_Languages') }} lang
on sel.LanguageId = lang.LanguageId