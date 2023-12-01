
SELECT
'Dynatrace' as Product,
'DWH_DIM_Dynatrace' as TableName,
'dynatrace' as tagName,
cast(max(date) as date) as LastUpdate,
case when cast(max(date) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 2 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_Dynatrace') }}

UNION ALL

SELECT
'FinOps' as Product,
'DWH_FACT_Billboard_Daily' as TableName,
'finops' as tagName,
cast(max(date) as date) as LastUpdate,
case when cast(max(date) as date) >= DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_FACT_Billboard_Daily') }}

UNION ALL

SELECT
'Contact' as Product,
'DWH_DIM_YuvalContact' as TableName,
'contact' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_YuvalContact') }}

UNION ALL

SELECT
'Customer' as Product,
'DWH_DIM_YuvalCustomer' as TableName,
'customer' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_YuvalCustomer') }}

UNION ALL

SELECT
'Ecom' as Product,
'DWH_FACT_Ecom_Payment' as TableName,
'ecom' as tagName,
cast(max(DateLastChanged) as date) as LastUpdate,
case when cast(max(DateLastChanged) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_FACT_Ecom_Payment') }}

UNION ALL

SELECT
'IT_Server' as Product,
'DWH_FACT_ITServer' as TableName,
'it' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_FACT_ITServer') }}

UNION ALL

SELECT
'Kiosk' as Product,
'DWH_FACT_Kiosk_Log_Daily_H' as TableName,
'kiosk' as tagName,
cast(max(Date) as date) as LastUpdate,
case when cast(max(Date) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_FACT_Kiosk_Log_Daily_H') }}

UNION ALL

SELECT
'Sso' as Product,
'DWH_FACT_Sso_By_Metric' as TableName,
'sso' as tagName,
cast(max(Date) as date) as LastUpdate,
case when cast(max(Date) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_FACT_Sso_By_Metric') }}

UNION ALL

SELECT
'DataOps' as Product,
'z_DataOps_Status_Table' as TableName,
'dataops' as tagName,
cast(max(LastModifiedDate) as date) as LastUpdate,
case when cast(max(LastModifiedDate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('z_DataOps_Status_Table') }}

UNION ALL

-- חריגים
SELECT
'Calendar' as Product,
'DWH_DIM_Date' as TableName,
'calendar' as tagName,
cast(DateFull as date) as LastUpdate,
case when DateFull = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_Date') }}
where IsCurrentDay is True


UNION ALL

SELECT
'DigitalLiteracy' as Product,
'DWH_DIM_DigitalLiteracy_Kayma' as TableName,
'diglit' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_DigitalLiteracy_Kayma') }}

UNION ALL

SELECT
'GCP' as Product,
'DWH_DIM_GCP_Project' as TableName,
'gcpops' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_GCP_Project') }}

UNION ALL

SELECT
'Ncc' as Product,
'DWH_DIM_DigitalLiteracy_Kayma' as TableName,
'ncc' as tagName,
cast(max(LastUpdate) as date) as LastUpdate,
case when cast(max(LastUpdate) as date) = DATE_SUB(CURRENT_DATE(), INTERVAL 0 DAY) then 'OK'
else 'MissData' end as Status
from {{ ref('DWH_DIM_DigitalLiteracy_Kayma') }}