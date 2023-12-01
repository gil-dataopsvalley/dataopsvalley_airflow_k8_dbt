from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("10_0_main_datagov_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="10_0_main_datagov_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers DataGov EL process DAGs',
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


# DataGov Status Resources:
datagov_status_resources_object_sensor = GCSObjectExistenceSensor(
    task_id='datagov_status_resources_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DataGov/Status/Resources/DataGov_Status_Resources_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

datagov_status_resources_trigger = TriggerDagRunOperator(
        task_id='trigger_datagov_status_resources_dag',
        trigger_dag_id='10_1_dag_datagov_status_resources',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# DataGov Status Results:
datagov_status_results_object_sensor = GCSObjectExistenceSensor(
    task_id='datagov_status_results_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DataGov/Status/Results/DataGov_Status_Results_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

datagov_status_results_trigger = TriggerDagRunOperator(
        task_id='trigger_datagov_status_results_dag',
        trigger_dag_id='10_1_dag_datagov_status_results',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# DataGov Splunk count by Country:
datagov_splunk_country_object_sensor = GCSObjectExistenceSensor(
    task_id='datagov_splunk_country_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DataGov/Splunk/DataGov_api_count_by_country/DataGov_api_count_by_country_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

datagov_splunk_country_trigger = TriggerDagRunOperator(
        task_id='trigger_datagov_splunk_country_dag',
        trigger_dag_id='10_1_dag_datagov_splunk_country',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# DataGov Splunk count by Resource ID:
datagov_splunk_resource_id_object_sensor = GCSObjectExistenceSensor(
    task_id='datagov_splunk_resource_id_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DataGov/Splunk/DataGov_api_count_by_resource_id/DataGov_api_count_by_resource_id_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

datagov_splunk_resource_id_trigger = TriggerDagRunOperator(
        task_id='trigger_datagov_splunk_resource_id_dag',
        trigger_dag_id='10_1_dag_datagov_splunk_resource_id',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# DataGov Splunk count by User Agent:
datagov_splunk_user_agent_id_object_sensor = GCSObjectExistenceSensor(
    task_id='datagov_splunk_user_agent_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DataGov/Splunk/DataGov_api_count_by_user_agent/DataGov_api_count_by_user_agent_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

datagov_splunk_user_agent_trigger = TriggerDagRunOperator(
        task_id='trigger_datagov_splunk_user_agent_dag',
        trigger_dag_id='10_1_dag_datagov_splunk_user_agent',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [datagov_status_resources_object_sensor >> datagov_status_resources_trigger,
          datagov_status_results_object_sensor >> datagov_status_results_trigger,
          datagov_splunk_country_object_sensor >> datagov_splunk_country_trigger,
          datagov_splunk_resource_id_object_sensor >> datagov_splunk_resource_id_trigger,
          datagov_splunk_user_agent_id_object_sensor >> datagov_splunk_user_agent_trigger] >> end


