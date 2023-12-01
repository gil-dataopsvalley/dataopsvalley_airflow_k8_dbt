with converted as (
    select
         filename,
         cast(updated_date_for_the_end_of_the_project as Date) as updated_date_for_the_end_of_the_project,
         cast(planned_date_for_the_end_of_the_project as Date) as planned_date_for_the_end_of_the_project,
         cast(project_start_date as Date) as project_start_date

    from {{ source('src_ncc', 'MRR_Ncc_projectTime')}}
    where project_start_date <> "44637"
  )

select
    filename,
    updated_date_for_the_end_of_the_project,
    planned_date_for_the_end_of_the_project,
    project_start_date,
    case
      when
          DATE_DIFF(cast(updated_date_for_the_end_of_the_project as date), cast(project_start_date as date), MONTH)/
           DATE_DIFF(cast(planned_date_for_the_end_of_the_project as date),cast(project_start_date as date), MONTH)
          > 1.25
        then "חריגה גדולה"
      when
          DATE_DIFF(cast(updated_date_for_the_end_of_the_project as date), cast(project_start_date as date), MONTH)/
           DATE_DIFF(cast(planned_date_for_the_end_of_the_project as date),cast(project_start_date as date), MONTH)
          > 1.01
        then "חריגה"
      else "אין חריגה"
    end delay_status,

    case
       when cast(updated_date_for_the_end_of_the_project as date)> cast(planned_date_for_the_end_of_the_project as date)
         then "כן"
       else "לא"
    end Isdelayed

 from converted
