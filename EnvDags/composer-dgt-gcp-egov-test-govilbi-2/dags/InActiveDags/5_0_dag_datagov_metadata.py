from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.models import Variable
from script_files import datagov_metadata_json_to_bq_urllib as datagov_metadata_to_bq_mrr

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("5_0_main_datagov_metadata_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

datagov_metadata_dag = DAG(
    dag_id="5_0_datagov_metadata_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='DataGov metadata EL process DAG',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=datagov_metadata_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=datagov_metadata_dag
    )


python_task_datagov_metadata_to_bq_mrr = PythonOperator(
        task_id='python_task_datagov_metadata_to_bq_mrr',
        python_callable=datagov_metadata_to_bq_mrr.main,
        dag=datagov_metadata_dag
    )


start >> python_task_datagov_metadata_to_bq_mrr >> end

