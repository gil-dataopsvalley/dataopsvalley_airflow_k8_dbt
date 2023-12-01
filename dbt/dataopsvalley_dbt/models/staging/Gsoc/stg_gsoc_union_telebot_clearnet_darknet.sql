select distinct
      Platform,
      Datetime,
      {{ isnull_en_string('GroupName') }} as GroupName,
      KeyWord,
      Severity,
      Message,
      Link,
      TranslatedMessage,
      SourceLanguage
  from {{ source('src_gsoc_telebot', 'MRR_Gsoc_TeleBOT') }}

  union all

  select distinct
      Platform,
      Datetime,
      cast(GroupName as string) as GroupName,
      KeyWord,
      Severity,
      TRIM(REGEXP_REPLACE(Message, R"\s+", " ")) as Message,
      Link,
      TRIM(REGEXP_REPLACE(replace(TranslatedMessage, "Title:",""), R"\s+", " ")) as TranslatedMessage,
      SourceLanguage
  from {{ ref('stg_gsoc_clearnet') }}

  union all

  select distinct
      Platform,
      Datetime,
      cast(GroupName as string) as GroupName,
      KeyWord,
      Severity,
      TRIM(REGEXP_REPLACE(Message, R"\s+", " ")) as Message,
      Link,
      TRIM(REGEXP_REPLACE(replace(TranslatedMessage, "Title:",""), R"\s+", " ")) as TranslatedMessage,
      SourceLanguage
  from {{ ref('stg_gsoc_darknet') }}

