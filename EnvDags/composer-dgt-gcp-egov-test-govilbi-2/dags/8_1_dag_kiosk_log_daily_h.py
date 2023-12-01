from airflow import DAG
from datetime import timedelta
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from script_files import incremental_load_kiosk_log_daily_h_json_to_bq as kiosk_log_daily_h_gcs_to_mrr

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

dag_python = DAG(
    dag_id="8_1_dag_kiosk_log_daily_h",
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    description='Kiosk Log Daily_H EL process DAG',
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

python_task_kiosk_log_daily_h_gcs_to_mrr = PythonOperator(
        task_id='kiosk_log_daily_h_gcs_to_mrr',
        python_callable=kiosk_log_daily_h_gcs_to_mrr.main,
        dag=dag_python
        )

start >> python_task_kiosk_log_daily_h_gcs_to_mrr >> end




