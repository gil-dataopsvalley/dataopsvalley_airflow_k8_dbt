import airflow
from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable
from script_files import load_dynatraceMetaData_json_to_bq as dynatrace_metadata_to_bq, \
    incremental_load_dynatrace_general_jsons_to_bq as dynatrace_general_to_bq

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("3_0_main_dynatrace_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
    }

dynatrace_dag = DAG(
    dag_id="3_0_dynatrace_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='dynatrace EL process',
    catchup=False,
    max_active_runs=1
    )

start = EmptyOperator(
    task_id='start',
    dag=dynatrace_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=dynatrace_dag
    )

# Dynatrace Metadata
dynatrace_metadata_object_sensor = GCSObjectExistenceSensor(
    task_id='dynatrace_metadata_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Dynatrace/MetaDataDynatrace/MetaDataDynatrace.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=dynatrace_dag
)

python_task_dynatrace_metadata_gcs_to_bq = PythonOperator(
        task_id='python_task_dynatrace_metadata_gcs_to_bq',
        python_callable=dynatrace_metadata_to_bq.main,
        dag=dynatrace_dag
        )

python_task_dynatrace_general_data_gcs_to_bq = PythonOperator(
        task_id='python_task_dynatrace_general_gcs_to_bq',
        python_callable=dynatrace_general_to_bq.main,
        dag=dynatrace_dag
        )

# Dynatrace dbt process
dynatrace_dbt_trigger = TriggerDagRunOperator(
        task_id='dynatrace_dbt_trigger',
        trigger_dag_id='3_1_dag_dynatrace_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=dynatrace_dag
)

start >> [dynatrace_metadata_object_sensor >> python_task_dynatrace_metadata_gcs_to_bq,
          python_task_dynatrace_general_data_gcs_to_bq] >> \
         dynatrace_dbt_trigger >> end



