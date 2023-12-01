with con_bud as(
select
  office,
  project_name,
  -- תקציב הפרוייקט
  cast({{ string_ncc_control_budget_cleaner('the_project_budget') }} as INT64) as project_budget,
  -- תקציב תמרוץ
  cast({{ string_ncc_control_budget_cleaner('timruth_budget') }} as INT64) as incentive_budget,
  -- תקציב משרדי (מאצ'ינג)
  cast({{ string_ncc_control_budget_cleaner('office_budget__matching_') }} as INT64) as office_budget_matching,
  -- תקציב תמרוץ+משרדי
  budget__incentive___office_ as incentive_plus_office_budget,
  -- האם תקציב הפרוייקט=תמרוץ+משרדי
  does_the_project_budget___incentive___office as is_project_budget_equal_incentive_plus_office,
  -- ביצוע מזומן תקציב תמרוץ
  cast({{ string_ncc_control_budget_cleaner('making_a_cash_budget_rush') }} as FLOAT64) as cash_used_from_incentive_budget,
  -- ביצוע תקציב משרדי
  making_an_office_budget as office_budget_used,
  -- סך התחיבויות
  cast({{ string_ncc_control_budget_cleaner('total_liabilities') }} as INT64) as total_commitments,
  -- התחייבות תקציב התמרוץ
  cast({{ string_ncc_control_budget_cleaner('timrutz_budget_commitments') }} as INT64) as incentive_budget_commitment,
  -- התחייבות תקציב משרדי (מאצ'ינג)
  case
      when {{ string_ncc_control_budget_cleaner('office_budget_commitments__matching_') }} = '0.00' then 0
      else cast({{ string_ncc_control_budget_cleaner('office_budget_commitments__matching_') }} as INT64)
  end as office_budget_commitment_matching,
  -- % ביצוע מזומן מתוך תקציב התמרוץ
  cast({{ string_ncc_control_budget_cleaner('__making_cash_out_of_the_timrutz_budget') }} as FLOAT64) as percentage_cash_used_from_incentive_budget,
  -- % ביצוע מזומן מתוך תקציב משרדי (מאצ'ינג)
  cast({{ string_ncc_control_budget_cleaner('__making_cash_out_of_the_office_budget__matching_') }} as FLOAT64) as percentage_office_budget_used_matching,
  -- % ביצוע התחייבות מתוך תקציב משרדי (מאצ'ינג)
  cast({{ string_ncc_control_budget_cleaner('__making_a_commitment_from_an_office_budget__matching_') }} as FLOAT64) as percentage_commitment_used_from_office_budget_matching,
  -- % ביצוע התחייבות מתוך תקציב התמרוץ
  cast({{ string_ncc_control_budget_cleaner('__making_a_commitment_out_of_the_timrutz_budget') }} as FLOAT64) as percentage_commitment_used_from_incentive_budget,
  IFNULL(cast({{ string_ncc_control_budget_cleaner('timruth_budget') }} as INT64), 0)
  + IFNULL(cast({{ string_ncc_control_budget_cleaner('office_budget__matching_') }} as INT64), 0) as total_actual_project_budget,
  period,
  remarks

from {{ source('src_ncc', 'MRR_Ncc_ControlBudeget') }}
where project_name is not null
and office_budget__matching_ <> ' ₪  - '
)

select
  office,
  project_name,
  project_budget,
  incentive_budget,
  office_budget_matching,
  incentive_plus_office_budget,
  is_project_budget_equal_incentive_plus_office,
  cash_used_from_incentive_budget,
  office_budget_used,
  total_commitments,
  incentive_budget_commitment,
  office_budget_commitment_matching,
  percentage_cash_used_from_incentive_budget,
  percentage_office_budget_used_matching,
  percentage_commitment_used_from_office_budget_matching,
  percentage_commitment_used_from_incentive_budget,
  total_actual_project_budget,
  period,
  ROW_NUMBER() OVER (partition by project_name ORDER BY period) as period_number,
  remarks

from con_bud
