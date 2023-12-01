from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.models import Variable
from script_files import GCP_Budget_To_BQ as gcp_budgets_to_bq_mrr

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("13_0_main_gcp_budgets_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

gcp_budgets_dag = DAG(
    dag_id="13_0_gcp_budgets_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='GCP Budgets EL process DAG',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=gcp_budgets_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=gcp_budgets_dag
    )


python_task_gcp_budgets_to_bq_mrr = PythonOperator(
        task_id='python_task_gcp_budgets_to_bq_mrr',
        python_callable=gcp_budgets_to_bq_mrr.main,
        dag=gcp_budgets_dag
    )


start >> python_task_gcp_budgets_to_bq_mrr >> end

