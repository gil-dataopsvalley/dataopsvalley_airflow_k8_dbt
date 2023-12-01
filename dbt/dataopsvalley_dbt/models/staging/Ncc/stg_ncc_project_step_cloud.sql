select
      f1 as cloud_step_description,
      case
        when f1 = 'תכנון' then 1
        when f1 = 'תמחור בספקיות' then 2
        when f1 = 'אפיון מפורט' then 3
        when f1 = 'מוכנות פרויקט' then 4
        when f1 = 'מוכנות צוות' then 5
        when f1 = 'פתיחת סעיף תקציבי לפרויקט' then 6
        when f1 = 'Onboarding אזור נחיתה' then 7
        when f1 = 'פיתוח בדיקות, יישום ותחזוקה' then 8
        else -1
      end as cloud_step_id,
      case when f2 = 'הושלם' then 1 else 0 end as executed_step,
      case when f2 = 'בתהליך עבודה' then 1 else 0 end as onboarding_step,
      case when f2 = 'טרם החל' then 1 else 0 end as before_execution_step,
      f2 as cloud_step_status,
      filename

from {{ source('src_ncc', 'MRR_Ncc_projectStepCloud')}}

