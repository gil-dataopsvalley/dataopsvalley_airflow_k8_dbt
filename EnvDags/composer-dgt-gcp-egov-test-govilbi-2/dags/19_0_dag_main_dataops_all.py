from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("19_0_main_dataops_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="19_0_main_dataops_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers Evc EL process DAGs',
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

# Evc dbt table_status
dataops_dbt_trigger = TriggerDagRunOperator(
        task_id='dataops_dbt_trigger',
        trigger_dag_id='19_1_dag_dataops_table_status_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> dataops_dbt_trigger >> end


