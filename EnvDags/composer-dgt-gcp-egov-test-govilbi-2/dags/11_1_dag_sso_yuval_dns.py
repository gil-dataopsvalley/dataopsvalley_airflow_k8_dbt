from airflow import DAG
from datetime import timedelta
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from script_files import load_sso_yuval_dns_json_to_bq as sso_yuval_dns_gcs_to_mrr

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=5)
}

dag_python = DAG(
    dag_id="11_1_dag_sso_yuval_dns",
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    description='SSO Yuval DNS EL process DAG',
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

python_task_sso_yuval_dns_gcs_to_bq_mrr = PythonOperator(
        task_id='python_task_sso_yuval_dns_gcs_to_bq_mrr',
        python_callable=sso_yuval_dns_gcs_to_mrr.main,
        dag=dag_python
        )

start >> python_task_sso_yuval_dns_gcs_to_bq_mrr >> end




