    SELECT
      Platform,
      max(Datetime) as Datetime,
      count(GroupName) as NumOfGroups,
      case when count(GroupName) = 0 then 'Link'
           else STRING_AGG(GroupName, '#')
      end as GroupNames,
      case
      -- התנאי של 0 קבוצות רלוונטי רק עבור פלטפורמת הדארקנט / קלירנט
        when count(GroupName) = 1 or count(GroupName) = 0 then max(Link)
        else "https://telegram.org/"
      end as Link,
      KeyWord,
      Severity,
      Message,
      TranslatedMessage,
--      left(TranslatedMessage,50) as Trunc_Translated,
      SourceLanguage,
      WeekDay,
      IsCurrentDay

    from {{ ref('stg_gsoc_union_telebot_clearnet_darknet') }} as union_data
    inner join {{ ref('DWH_DIM_Date') }} as dates
    on cast(split(cast(Datetime as string), ' ')[ORDINAL(1)] as Date)  = dates.DateFull
    group by
      Platform,
      KeyWord,
      Severity,
      Message,
      TranslatedMessage,
      SourceLanguage,
      WeekDay,
      IsCurrentDay