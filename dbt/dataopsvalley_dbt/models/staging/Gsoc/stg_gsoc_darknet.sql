select distinct
      Platform,
      Datetime,
      null as GroupName,
      KeyWord,
      Severity,
      TRIM(REGEXP_REPLACE(Message, R"\s+", " ")) as Message,
      Link,
      TRIM(REGEXP_REPLACE(replace(TranslatedMessage, "Title:",""), R"\s+", " ")) as TranslatedMessage,
      SourceLanguage
  from {{ source('src_gsoc_darknet', 'MRR_Gsoc_DarkNet') }}