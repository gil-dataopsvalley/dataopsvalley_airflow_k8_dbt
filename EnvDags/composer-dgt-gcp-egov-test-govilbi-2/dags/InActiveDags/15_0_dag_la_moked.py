from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable
from script_files import load_la_moked_json_to_bq as la_moked_to_bq_mrr

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("15_0_main_la_moked_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

la_moked_dag = DAG(
    dag_id="15_0_la_moked_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers  La Moked EL process DAGs',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=la_moked_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=la_moked_dag
    )

# La Moked
la_moked_object_sensor = GCSObjectExistenceSensor(
    task_id='la_moked_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/LA/LA_Moked/LA_Moked_'
           f'{(datetime.today()).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=la_moked_dag
)

python_task_la_moked_to_bq_mrr = PythonOperator(
        task_id='python_task_la_moked_to_bq_mrr',
        python_callable=la_moked_to_bq_mrr.main,
        dag=la_moked_dag
)

# La Moked dbt process
la_moked_dbt_trigger = TriggerDagRunOperator(
        task_id='la_moked_dbt_trigger',
        trigger_dag_id='15_1_dag_la_moked_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=la_moked_dag
)

start >> la_moked_object_sensor >> python_task_la_moked_to_bq_mrr >> la_moked_dbt_trigger >> end

