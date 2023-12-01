from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectsWithPrefixExistenceSensor #GCSObjectsWithPrefixExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("1_0_main_ncc_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="1_0_main_ncc_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers NCC EL process DAGs',
    catchup=False,
    max_active_runs=2
)


start = EmptyOperator(
    task_id='start',
    dag=main_dag
)


end = EmptyOperator(
    task_id='end',
    dag=main_dag
)


# NCC ControlBudget:
ncc_control_budget_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_control_budget_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_ControlBudeget/Ncc_ControlBudeget_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_control_budget_trigger = TriggerDagRunOperator(
        task_id='ncc_control_budget_trigger',
        trigger_dag_id='1_1_dag_ncc_control_budget',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Milestones:
ncc_milestones_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_milestones_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Milestones/Ncc_Milestones_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_milestones_trigger = TriggerDagRunOperator(
        task_id='ncc_milestones_trigger',
        trigger_dag_id='1_1_dag_ncc_milestones',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Office_BarriersChallenges:
ncc_office_barriers_challenges_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_office_barriers_challenges_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Office_BarriersChallenges/Ncc_Office_BarriersChallenges_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_office_barriers_challenges_trigger = TriggerDagRunOperator(
        task_id='ncc_office_barriers_challenges_trigger',
        trigger_dag_id='1_1_dag_ncc_office_barriers_challenges',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Office_Data:
ncc_office_data_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_office_data_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Office_Data/Ncc_Office_Data_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_office_data_trigger = TriggerDagRunOperator(
        task_id='ncc_office_data_trigger',
        trigger_dag_id='1_1_dag_ncc_office_data',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Office_GapFindings:
ncc_office_gap_findings_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_office_gap_findings_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Office_GapFindings/Ncc_Office_GapFindings_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_office_gap_findings_trigger = TriggerDagRunOperator(
        task_id='ncc_office_gap_findings_trigger',
        trigger_dag_id='1_1_dag_ncc_office_gap_findings',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Office_QuestionsAndAnswers:
ncc_office_questions_and_answers_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_office_questions_and_answers_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Office_QuestionsAndAnswers/Ncc_Office_QuestionsAndAnswers_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_office_questions_and_answers_trigger = TriggerDagRunOperator(
        task_id='ncc_office_questions_and_answers_trigger',
        trigger_dag_id='1_1_dag_ncc_office_questions_and_answers',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC Office_Rating:
ncc_office_rating_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_office_rating_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_Office_Rating/Ncc_Office_Rating_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_office_rating_trigger = TriggerDagRunOperator(
        task_id='ncc_office_rating_trigger',
        trigger_dag_id='1_1_dag_ncc_office_rating',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC ProjectAssistance:
ncc_project_assistance_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_assistance_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_ProjectAssistance/Ncc_ProjectAssistance_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_assistance_trigger = TriggerDagRunOperator(
        task_id='ncc_project_assistance_trigger',
        trigger_dag_id='1_1_dag_ncc_project_assistance',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC ProjectName:
ncc_project_name_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_name_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_ProjectName/Ncc_ProjectName_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_name_trigger = TriggerDagRunOperator(
        task_id='ncc_project_name_trigger',
        trigger_dag_id='1_1_dag_ncc_project_name',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC SizeOffice:
ncc_size_office_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_size_office_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_SizeOffice/Ncc_SizeOffice_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_size_office_trigger = TriggerDagRunOperator(
        task_id='ncc_size_office_trigger',
        trigger_dag_id='1_1_dag_ncc_size_office',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC projectDetail:
ncc_project_detail_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_detail_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_projectDetail/Ncc_projectDetail_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_detail_trigger = TriggerDagRunOperator(
        task_id='ncc_project_detail_trigger',
        trigger_dag_id='1_1_dag_ncc_project_detail',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC projectStepCloud:
ncc_project_step_cloud_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_step_cloud_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_projectStepCloud/Ncc_projectStepCloud_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_step_cloud_trigger = TriggerDagRunOperator(
        task_id='ncc_project_step_cloud_trigger',
        trigger_dag_id='1_1_dag_ncc_project_step_cloud',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC projectTime:
ncc_project_time_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_time_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_projectTime/Ncc_projectTime_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_time_trigger = TriggerDagRunOperator(
        task_id='ncc_project_time_trigger',
        trigger_dag_id='1_1_dag_ncc_project_time',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC projectControlsubChallenge:
ncc_project_control_sub_challenge_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='ncc_project_control_sub_challenge_object_sensor',
    bucket='govilbi_files',
    prefix=f'GovilFromOnPrem/Ncc/Ncc_projectControlsubChallenge/Ncc_projectControlsubChallenge_',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ncc_project_control_sub_challenge_trigger = TriggerDagRunOperator(
        task_id='ncc_project_control_sub_challenge_trigger',
        trigger_dag_id='1_1_dag_ncc_project_control_sub_challenge',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# NCC dbt process
ncc_dbt_trigger = TriggerDagRunOperator(
        task_id='ncc_dbt_trigger',
        trigger_dag_id='1_1_dag_ncc_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [ncc_control_budget_object_sensor >> ncc_control_budget_trigger,
          ncc_milestones_object_sensor >> ncc_milestones_trigger,
          ncc_office_barriers_challenges_object_sensor >> ncc_office_barriers_challenges_trigger,
          ncc_office_data_object_sensor >> ncc_office_data_trigger,
          ncc_office_gap_findings_object_sensor >> ncc_office_gap_findings_trigger,
          ncc_office_questions_and_answers_object_sensor >> ncc_office_questions_and_answers_trigger,
          ncc_office_rating_object_sensor >> ncc_office_rating_trigger,
          ncc_project_assistance_object_sensor >> ncc_project_assistance_trigger,
          ncc_project_name_object_sensor >> ncc_project_name_trigger,
          ncc_size_office_object_sensor >> ncc_size_office_trigger,
          ncc_project_detail_object_sensor >> ncc_project_detail_trigger,
          ncc_project_step_cloud_object_sensor >> ncc_project_step_cloud_trigger,
          ncc_project_time_object_sensor >> ncc_project_time_trigger,
          ncc_project_control_sub_challenge_object_sensor >> ncc_project_control_sub_challenge_trigger] \
         >> ncc_dbt_trigger >> end


