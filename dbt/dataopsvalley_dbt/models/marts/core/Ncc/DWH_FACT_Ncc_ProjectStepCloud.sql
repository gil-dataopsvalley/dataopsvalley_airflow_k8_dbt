select
      cloud_step_description,
      cloud_step_id,
      executed_step,
      onboarding_step,
      before_execution_step,
      cloud_step_status,
      filename

from {{ ref('stg_ncc_project_step_cloud')}}

