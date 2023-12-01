from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("16_0_main_emun_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="16_0_main_emun_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers Emun EL process DAGs',
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


# Emun Casualties:
emun_casualties_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_casualties_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/Casualties/Emun_Casualties_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_casualties_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_casualties_dag',
        trigger_dag_id='16_1_dag_emun_casualties',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun CasualtiesByLocalAuthority:
emun_casualties_by_local_authority_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_casualties_by_local_authority_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/CasualtiesByLocalAuthority/Emun_CasualtiesByLocalAuthority_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_casualties_by_local_authority_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_casualties_by_local_authority_dag',
        trigger_dag_id='16_1_dag_emun_casualties_by_local_authority',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun CurrentInformationMinistryEducation:
emun_current_information_ministry_education_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_current_information_ministry_education_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/CurrentInformationMinistryEducation/Emun_CurrentInformationMinistryEducation_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_current_information_ministry_education_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_current_information_ministry_education_dag',
        trigger_dag_id='16_1_dag_emun_current_information_ministry_education',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun EvacueesByShalterType:
emun_evacuees_by_shalter_type_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_evacuees_by_shalter_type_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/EvacueesByShalterType/Emun_EvacueesByShalterType_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_evacuees_by_shalter_type_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_evacuees_by_shalter_type_dag',
        trigger_dag_id='16_1_dag_emun_evacuees_by_shalter_type',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun EvacueesSettlementAuthority:
emun_evacuees_settlement_authority_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_evacuees_settlement_authority_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/EvacueesSettlementAuthority/Emun_EvacueesSettlementAuthority_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_evacuees_settlement_authority_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_evacuees_settlement_authority_dag',
        trigger_dag_id='16_1_dag_emun_evacuee_ssettlement_authority',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun SingleDataTable:
emun_single_data_table_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_single_data_table_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/StatusHospitals/Emun_StatusHospitals_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_single_data_table_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_single_data_table_dag',
        trigger_dag_id='16_1_dag_emun_single_data_table',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun StatusHospitals:
emun_status_hospitals_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_status_hospitals_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/StatusHospitals/Emun_StatusHospitals_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_status_hospitals_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_status_hospitals_dag',
        trigger_dag_id='16_1_dag_emun_status_hospitals',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun Unemployment:
emun_unemployment_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_unemployment_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/Unemployment/Emun_Unemployment_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_unemployment_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_unemployment_dag',
        trigger_dag_id='16_1_dag_emun_unemployment',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun UnemploymentJobClaimsByBranches:
emun_unemployment_job_claims_by_branches_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_unemployment_job_claims_by_branches_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/UnemploymentJobClaimsByBranches/Emun_UnemploymentJobClaimsByBranches_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_unemployment_job_claims_by_branches_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_unemployment_job_claims_by_branches_dag',
        trigger_dag_id='16_1_dag_emun_unemployment_job_claims_by_branches',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emun Victims:
emun_victims_object_sensor = GCSObjectExistenceSensor(
    task_id='emun_victims_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emun/Victims/Emun_Victims_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

emun_victims_trigger = TriggerDagRunOperator(
        task_id='trigger_emun_victims_dag',
        trigger_dag_id='16_1_dag_emun_victims',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


start >> [emun_casualties_object_sensor >> emun_casualties_trigger,
          emun_casualties_by_local_authority_object_sensor >> emun_casualties_by_local_authority_trigger,
          emun_current_information_ministry_education_object_sensor >> emun_current_information_ministry_education_trigger,
          emun_evacuees_by_shalter_type_object_sensor >> emun_evacuees_by_shalter_type_trigger,
          emun_evacuees_settlement_authority_object_sensor >> emun_evacuees_settlement_authority_trigger,
          emun_single_data_table_object_sensor >> emun_single_data_table_trigger,
          emun_status_hospitals_object_sensor >> emun_status_hospitals_trigger,
          emun_unemployment_object_sensor >> emun_unemployment_trigger,
          emun_unemployment_job_claims_by_branches_object_sensor >> emun_unemployment_job_claims_by_branches_trigger,
          emun_victims_object_sensor >> emun_victims_trigger] >> end



