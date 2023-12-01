with Musdar as (
SELECT fromCityUnion_code, fromCityUnion, shelterCityUnion_Code, shelterCityUnion_Name, Child_Adult, count(*) as TotalCount
FROM {{ ref('DWH_DIM_Evc_Ironswords_List_All') }}
where shelterType = 'מוסדר'
group by fromCityUnion_code, fromCityUnion, shelterCityUnion_Code, shelterCityUnion_Name, Child_Adult
),

NotMusdar as (
SELECT fromCityUnion_code, fromCityUnion, shelterCityUnion_Code, shelterCityUnion_Name, Child_Adult, count(*) as TotalCount
FROM {{ ref('DWH_DIM_Evc_Ironswords_List_All') }}
where shelterType = 'לא מוסדר'
group by fromCityUnion_code, fromCityUnion, shelterCityUnion_Code, shelterCityUnion_Name, Child_Adult
)

select  ifnull(Musdar.fromCityUnion_code, NotMusdar.fromCityUnion_code) as fromCity_code,
        ifnull(Musdar.fromCityUnion, NotMusdar.fromCityUnion) as fromCity,
        ifnull(Musdar.shelterCityUnion_Code, NotMusdar.shelterCityUnion_Code) as shelterCityUnion_Code,
        ifnull(Musdar.shelterCityUnion_Name, NotMusdar.shelterCityUnion_Name) as shelterCityUnion_Name,
        ifnull(Musdar.Child_Adult, NotMusdar.Child_Adult) as Child_Adult,
        Musdar.TotalCount as Musdar_Count,
        NotMusdar.TotalCount as NotMusdar_Count

from Musdar
full outer join NotMusdar
  on Musdar.fromCityUnion_code = NotMusdar.fromCityUnion_code
  and Musdar.shelterCityUnion_Code = NotMusdar.shelterCityUnion_Code
  and Musdar.Child_Adult = NotMusdar.Child_Adult
