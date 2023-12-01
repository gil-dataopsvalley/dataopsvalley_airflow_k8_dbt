select  SettelmentSymbolNumber,
        SettelmentName,
        CouncilFullName,
        localAuthorityType,
        TotalPopulation,
        IsEvacuated,
        EvacuationDate,
        Distance

from {{ ref('stg_evc_ironswords_TownsPopulation') }}
