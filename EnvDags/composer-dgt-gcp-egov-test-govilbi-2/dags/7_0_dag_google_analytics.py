from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.models import Variable
from script_files import ga4_to_bq

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("7_0_main_google_analytics_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

ga_dag = DAG(
    dag_id="7_0_google_analytics_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Google Analytics data EL process DAG',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=ga_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=ga_dag
    )


# GA4
python_task_ga4_to_bq_mrr = PythonOperator(
        task_id='python_task_ga4_to_bq_mrr',
        python_callable=ga4_to_bq.main,
        dag=ga_dag
    )


start >> [python_task_ga4_to_bq_mrr] >> end

