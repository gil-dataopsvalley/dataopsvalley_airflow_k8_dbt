from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("9_0_main_ecom_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="9_0_main_ecom_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers eCom EL process DAGs',
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


# eCom v_Ecom:
ecom_v_ecom_object_sensor = GCSObjectExistenceSensor(
    task_id='ecom_v_ecom_object_sensor',
    bucket='govilbi_files',
        object=f'GovilFromOnPrem/Ecom/Ecom_v_ecom/Ecom_v_ecom_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ecom_v_ecom_trigger = TriggerDagRunOperator(
        task_id='trigger_ecom_v_ecom_dag',
        trigger_dag_id='9_1_dag_ecom_v_ecom',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# eCom Services:
ecom_services_object_sensor = GCSObjectExistenceSensor(
    task_id='ecom_services_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Ecom/Ecom_Services/Ecom_Services_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

ecom_services_trigger = TriggerDagRunOperator(
        task_id='trigger_ecom_services_dag',
        trigger_dag_id='9_1_dag_ecom_services',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Ecom dbt process
ecom_dbt_trigger = TriggerDagRunOperator(
        task_id='ecom_dbt_trigger',
        trigger_dag_id='9_1_dag_ecom_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [ecom_v_ecom_object_sensor >> ecom_v_ecom_trigger,
          ecom_services_object_sensor >> ecom_services_trigger] \
         >> ecom_dbt_trigger >> end


