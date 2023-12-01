select
    CustomerCRMCode,
    CustomerName,
    Domain,
    organization as Organization,
    PaymentsCount,
    PaymentsSum,
    cast(DateLastChanged as Date) as DateLastChanged,
--    cast(FORMAT_DATE('%F', DATE(cast(SPLIT(DateLastChanged, '/')[ORDINAL(3)] as int),
--                                cast(SPLIT(DateLastChanged, '/')[ORDINAL(2)] as int),
--                                cast(SPLIT(DateLastChanged, '/')[ORDINAL(1)] as int))) as DATE) as DateLastChanged,
    esrc.ServiceCode as ServiceCode,
    esrc.officeId as OfficeIdEcom,
    OfficeName as OfficeNameEcom,
    transaction_type as TransactionType,
    station_id as StationId,
    PayMethodCode,
    case
    when PayMethodCode = '00010' then 'בנקים'
    when PayMethodCode = '00011' then 'בנקים'
    when PayMethodCode = '00012' then 'בנקים'
    when PayMethodCode = '00013' then 'בנקים'
    when PayMethodCode = '00014' then 'בנקים'
    when PayMethodCode = '00017' then 'בנקים'
    when PayMethodCode = '00020' then 'בנקים'
    when PayMethodCode = '00026' then 'בנקים'
    when PayMethodCode = '00031' then 'בנקים'
    when PayMethodCode = '00046' then 'בנקים'
    when PayMethodCode = '00052' then 'בנקים'
    when PayMethodCode = '00022' then 'citi'
    when PayMethodCode = '00023' then 'HSBC'
    when UPPER(TRIM(PayMethodCode)) = 'AMEX' then 'כרטיס אשראי'
    when PayMethodCode = 'ISRAC' then 'כרטיס אשראי'
    when PayMethodCode = 'LEUMI' then 'כרטיס אשראי'
    when PayMethodCode = 'NoPay' then 'כרטיס אשראי'
    when UPPER(TRIM(PayMethodCode)) = 'VISA' then 'כרטיס אשראי'
    when PayMethodCode = 'scard' then 'כרטיס חכם'
    else 'אחר'
    end as PayMethodDesc,
    case
    when PayMethodCode = '00010' then 'בנק לאומי'
    when PayMethodCode = '00011' then 'דיסקונט'
    when PayMethodCode = '00012' then 'פועלים'
    when PayMethodCode = '00013' then 'איגוד'
    when PayMethodCode = '00014' then 'אוצר החייל'
    when PayMethodCode = '00017' then 'מרכנתיל דיסקונט'
    when PayMethodCode = '00020' then 'מזרחי'
    when PayMethodCode = '00026' then 'יו בנק'
    when PayMethodCode = '00031' then 'בינלאומי'
    when PayMethodCode = '00046' then 'מסד'
    when PayMethodCode = '00052' then 'פאגי'
    when PayMethodCode = '00022' then 'citi'
    when PayMethodCode = '00023' then 'HSBC'
    when UPPER(TRIM(PayMethodCode)) = 'AMEX' then 'אמריקן אקספרס'
    when PayMethodCode = 'DINRS' then 'דיינרס'
    when PayMethodCode = 'ISRAC' then 'ישראכרט'
    when PayMethodCode = 'LEUMI' then 'לאומי קארד'
    when PayMethodCode = 'NoPay' then 'כרטיס אשראי'
    when UPPER(TRIM(PayMethodCode)) = 'VISA' then 'כרטיס אשראי'
    when PayMethodCode = 'scard' then 'כרטיס חכם'
    else 'אחר'
    end PayMethodCategory,
     {{ isnull_en_string('oneclick_pay_method') }} as OneclickPayMethod,
    case when cc_mutag = 'VIZA' then 'VISA'
         when cc_mutag = 'ISRAC' then 'ISRACARD'
         when cc_mutag is null or cc_mutag = '' then 'Unknown' else cc_mutag end as CcMutag,
    esrc.CommerceName as CommerceName,
    ecomServ.ServiceDesc as ServiceDesc

from {{ source('src_ecom', 'MRR_Ecom_v_ecom') }} esrc
left join {{ ref('stg_ecom_customer_details') }} ec
 on esrc.officeId = ec.officeId_Ecom
left join {{ ref('stg_ecom_services') }} ecomServ
 on ecomServ.ServiceCode = esrc.ServiceCode
    and ecomServ.CommerceName = esrc.CommerceName
