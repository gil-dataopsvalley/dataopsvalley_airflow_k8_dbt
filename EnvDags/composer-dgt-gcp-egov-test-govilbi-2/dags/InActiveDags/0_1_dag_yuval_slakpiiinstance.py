from airflow import DAG
from datetime import timedelta
from airflow.utils.dates import days_ago
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from script_files import load_slakpiinstance_json_to_bq as slakpiinstance_to_mrr


default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    'retry_delay': timedelta(minutes=60)
}

yuval_slakpiinstance_dag = DAG(
    dag_id="0_1_dag_yuval_slakpiinstance",
    default_args=default_args,
    schedule_interval=None,
    start_date=days_ago(1),
    description='triggers yuval Slakpiinstance EL process DAG',
    catchup=False,
    max_active_runs=1
)

start = EmptyOperator(
    task_id='start',
    dag=yuval_slakpiinstance_dag
)

end = EmptyOperator(
    task_id='end',
    dag=yuval_slakpiinstance_dag
)


python_task_slakpiinstance_gcs_to_bq_mrr = PythonOperator(
        task_id='python_task_slakpiinstance_gcs_to_bq_mrr',
        python_callable=slakpiinstance_to_mrr.main,
        dag=yuval_slakpiinstance_dag
)


start >> python_task_slakpiinstance_gcs_to_bq_mrr >> end

