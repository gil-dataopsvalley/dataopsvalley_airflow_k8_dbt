from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable
from script_files import load_servers_json_to_bq as it_servers_to_mrr, \
load_MappingITServerCustomerToYuval_json_to_bq as it_servers_customers_to_mrr

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("2_0_main_it_server_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

it_servers_dag = DAG(
    dag_id="2_0_it_servers_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='triggers IT servers EL process DAG',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=it_servers_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=it_servers_dag
    )

it_servers_object_sensor = GCSObjectExistenceSensor(
    task_id='it_servers_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/IT/Servers/Server.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=it_servers_dag
    )


python_task_it_servers_gcs_to_bq_mrr = PythonOperator(
        task_id='python_task_it_servers_gcs_to_bq_mrr',
        python_callable=it_servers_to_mrr.main,
        dag=it_servers_dag
    )


it_servers_customers_object_sensor = GCSObjectExistenceSensor(
    task_id='it_servers_customers_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/IT/MappingITServerCustomerToYuval/MappingITServerCustomerToYuval.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=it_servers_dag
    )


python_task_it_servers_customers_gcs_to_bq_mrr = PythonOperator(
        task_id='python_task_it_servers_customers_gcs_to_bq_mrr',
        python_callable=it_servers_customers_to_mrr.main,
        dag=it_servers_dag
        )

# IT servers dbt process
it_servers_dbt_trigger = TriggerDagRunOperator(
        task_id='it_servers_dbt_trigger',
        trigger_dag_id='2_1_dag_it_servers_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=it_servers_dag
)

start >> [it_servers_object_sensor >> python_task_it_servers_gcs_to_bq_mrr,
          it_servers_customers_object_sensor >> python_task_it_servers_customers_gcs_to_bq_mrr] \
         >> it_servers_dbt_trigger >> end

