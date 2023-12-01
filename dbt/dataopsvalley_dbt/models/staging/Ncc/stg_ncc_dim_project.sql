select
      proj.filename,
      proj.office_name,
      proj.project_name,
      p_time.updated_date_for_the_end_of_the_project,
      p_time.planned_date_for_the_end_of_the_project,
      p_time.project_start_date,
      p_time.delay_status,
      p_time.Isdelayed,
      con_bud.office_budget_matching,
      con_bud.project_budget,
      con_bud.incentive_budget,
      con_bud.incentive_budget_commitment,
      con_bud.office_budget_commitment_matching,
      con_bud.total_commitments,
      con_bud.percentage_cash_used_from_incentive_budget,
      con_bud.percentage_office_budget_used_matching,
      con_bud.percentage_commitment_used_from_office_budget_matching,
      con_bud.percentage_commitment_used_from_incentive_budget,
      con_bud.cash_used_from_incentive_budget,
      con_bud.total_actual_project_budget,
      con_bud.period,
      con_bud.period_number,
      con_bud.remarks,
      size_office.office_size


from {{ ref('stg_ncc_project_name')}} proj
left join {{ ref('stg_ncc_project_time') }} p_time
on proj.filename = p_time.filename
inner join {{ ref('stg_ncc_control_budget') }} con_bud
on proj.project_name = con_bud.project_name
left join {{ ref('stg_ncc_size_office') }} size_office
on proj.office_name = size_office.office_name
