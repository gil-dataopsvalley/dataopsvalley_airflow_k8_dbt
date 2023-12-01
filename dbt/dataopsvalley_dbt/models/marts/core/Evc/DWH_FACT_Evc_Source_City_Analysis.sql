select
    city.fromCity,
    pop.CouncilFullName,
    pop.localAuthorityType,
    pop.TotalPopulation,
    IFNULL(sum(city.Musdar_Count + city.NotMusdar_Count), 0) as EvacuatedPopulation

from {{ ref('DWH_FACT_Evc_Source_Destination_Cities') }} city
left join {{ ref('DWH_DIM_Evc_TownsPopulation') }} pop
on city.fromCity_code = pop.SettelmentSymbolNumber
where city.fromCity is not null
group by
    city.fromCity,
    pop.CouncilFullName,
    pop.localAuthorityType,
    pop.TotalPopulation
