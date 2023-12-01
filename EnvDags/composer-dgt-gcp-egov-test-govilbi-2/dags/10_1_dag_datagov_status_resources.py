from airflow import DAG
from datetime import timedelta
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from script_files import load_datagov_status_resources_json_to_bq as datagov_status_resources_gcs_to_mrr

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
    }

datagov_status_dag = DAG(
    dag_id="10_1_dag_datagov_status_resources",
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    description='Datagov Status EL process',
    catchup=False,
    max_active_runs=1
    )

start = EmptyOperator(
    task_id='start',
    dag=datagov_status_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=datagov_status_dag
    )

python_task_datagov_status_resources_gcs_to_mrr = PythonOperator(
        task_id='python_task_datagov_status_resources_gcs_to_mrr',
        python_callable=datagov_status_resources_gcs_to_mrr.main,
        dag=datagov_status_dag
        )

start >> python_task_datagov_status_resources_gcs_to_mrr >> end
