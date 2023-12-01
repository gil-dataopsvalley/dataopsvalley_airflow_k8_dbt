select
    city.shelterCityUnion_Name,
    pop.CouncilFullName,
    pop.localAuthorityType,
    pop.TotalPopulation,
    IFNULL(sum(city.Musdar_Count + city.NotMusdar_Count), 0) as EvacuatedPopulation


from {{ ref('DWH_FACT_Evc_Source_Destination_Cities') }} city
left join {{ ref('DWH_DIM_Evc_TownsPopulation') }} pop
on city.shelterCityUnion_Code = pop.SettelmentSymbolNumber
group by
    city.shelterCityUnion_Name,
    pop.CouncilFullName,
    pop.localAuthorityType,
    pop.TotalPopulation
