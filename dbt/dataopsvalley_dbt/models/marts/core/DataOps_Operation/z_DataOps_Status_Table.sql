SELECT
    row_number() over (order by last_modified_time) as TableIndex,
    project_id as ProjectId,
    dataset_id as DatasetId,
    table_id as TableId,
    case when type = 1 then 'Table'
         when type = 2 then 'View'
         else 'Other'
    end as Type,
    row_count as RowCount,
    TIMESTAMP_MILLIS(last_modified_time) as LastModifiedDate

FROM `dgt-gcp-egov-test-govilbi-0.GovilBiDwhDS.__TABLES__`
order by last_modified_time