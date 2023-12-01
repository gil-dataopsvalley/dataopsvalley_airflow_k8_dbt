from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectsWithPrefixExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("6_0_main_gsoc_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="6_0_main_gsoc_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers GSOC EL process DAGs',
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


# Gsoc TeleBOT:
gsoc_telebot_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='gsoc_telebot_object_sensor',
    bucket='govilbi_gsoc',
    prefix=f'jsonFiles/TeleBOT/TeleBOT_',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

gsoc_telebot_trigger = TriggerDagRunOperator(
        task_id='gsoc_telebot_trigger',
        trigger_dag_id='6_1_dag_gsoc_telebot',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Gsoc CyberINT/Credentials Exposed:
gsoc_cyberint_credentials_exposed_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='gsoc_cyberint_credentials_exposed_object_sensor',
    bucket='govilbi_gsoc',
    prefix=f'jsonFiles/CyberINT/Credentials Exposed/CyberINT_Credential_Exposed_',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

gsoc_cyberint_credentials_exposed_trigger = TriggerDagRunOperator(
        task_id='gsoc_cyberint_credentials_exposed_trigger',
        trigger_dag_id='6_1_dag_gsoc_cyberint_credentials_exposed',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Gsoc ClearNet:
gsoc_clearnet_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='gsoc_clearnet_object_sensor',
    bucket='govilbi_gsoc',
    prefix=f'jsonFiles/ClearNet/ClearNet_',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

gsoc_clearnet_trigger = TriggerDagRunOperator(
        task_id='gsoc_clearnet_trigger',
        trigger_dag_id='6_1_dag_gsoc_clearnet',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Gsoc DarkNet:
gsoc_darknet_object_sensor = GCSObjectsWithPrefixExistenceSensor(
    task_id='gsoc_darknet_object_sensor',
    bucket='govilbi_gsoc',
    prefix=f'jsonFiles/DarkNet/DarkNet_',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

gsoc_darknet_trigger = TriggerDagRunOperator(
        task_id='gsoc_darknet_trigger',
        trigger_dag_id='6_1_dag_gsoc_darknet',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Gsoc dbt process
gsoc_dbt_trigger = TriggerDagRunOperator(
        task_id='gsoc_dbt_trigger',
        trigger_dag_id='6_1_dag_gsoc_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


gsoc_telebot_clearnet_csv_exporter_trigger = TriggerDagRunOperator(
        task_id='gsoc_telebot_clearnet_csv_exporter_trigger',
        trigger_dag_id='6_1_dag_gsoc_telebot_clearnet_csv_exporter',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


start >> [gsoc_telebot_object_sensor >> gsoc_telebot_trigger,
          gsoc_cyberint_credentials_exposed_object_sensor >> gsoc_cyberint_credentials_exposed_trigger,
          gsoc_clearnet_object_sensor >> gsoc_clearnet_trigger,
          gsoc_darknet_object_sensor >> gsoc_darknet_trigger] \
         >> gsoc_dbt_trigger >> gsoc_telebot_clearnet_csv_exporter_trigger >> end


