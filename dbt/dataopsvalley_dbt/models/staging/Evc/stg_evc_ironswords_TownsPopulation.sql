select
    pop.settlement_symbol as SettelmentSymbolNumber,
    trim(pop.settlement_name) as SettelmentName,
    case when pop.code_regional_council = 0 then trim(pop.settlement_name)
         else trim(pop.regional_council)
    end as CouncilFullName,
    case when pop.code_regional_council <> 0 then 'מועצה אזורית'
         when pop.total > 20000 then 'עירייה'
         else 'מועצה מקומית'
    end as localAuthorityType,
    pop.total as TotalPopulation,
    case when evac.SettelmentSymbolNumber is not null then TRUE else FALSE end as IsEvacuated,
    evac.EvacuationDate,
    evac.Distance

from  {{ source('src_Datagov', 'MRR_Datagov_Piba_Population') }} pop
left join {{ source('src_evc', 'MRR_Evc_ListEvacuatedTowns') }} evac
    on pop.settlement_symbol = cast(evac.SettelmentSymbolNumber as INT)

