from airflow import DAG
from datetime import timedelta
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from script_files import export_bq_to_csv_to_gcs as export_bq_to_csv_to_gcs

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

dag_python = DAG(
    dag_id="6_1_dag_gsoc_telebot_clearnet_csv_exporter",
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    description='Gsoc Telebot Clearnet CSV Exporter EL process DAG',
    catchup=False,
    max_active_runs=1
    )


start = EmptyOperator(
    task_id='start',
    dag=dag_python
)

end = EmptyOperator(
    task_id='end',
    dag=dag_python
)

python_task_gsoc_telebot_clearnet_csv_exporter = PythonOperator(
        task_id='python_task_gsoc_telebot_clearnet_csv_exporter',
        python_callable=export_bq_to_csv_to_gcs.main,
        dag=dag_python
        )

start >> python_task_gsoc_telebot_clearnet_csv_exporter >> end




