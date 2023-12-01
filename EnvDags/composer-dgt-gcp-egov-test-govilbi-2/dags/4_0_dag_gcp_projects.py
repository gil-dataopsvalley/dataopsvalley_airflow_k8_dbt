from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.python import PythonOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.models import Variable
from script_files import gcp_metadata_to_bq as gcp_projects_to_bq_mrr

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("4_0_main_gcp_projects_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}

gcp_projects_dag = DAG(
    dag_id="4_0_gcp_projects_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='GCP projects metadata EL process DAG',
    catchup=False,
    max_active_runs=2
    )

start = EmptyOperator(
    task_id='start',
    dag=gcp_projects_dag
    )

end = EmptyOperator(
    task_id='end',
    dag=gcp_projects_dag
    )


python_task_gcp_projects_to_bq_mrr = PythonOperator(
        task_id='python_task_gcp_projects_to_bq_mrr',
        python_callable=gcp_projects_to_bq_mrr.main,
        dag=gcp_projects_dag
    )

# GCP Ops dbt process
gcpops_dbt_trigger = TriggerDagRunOperator(
        task_id='gcpops_dbt_trigger',
        trigger_dag_id='4_1_dag_gcpops_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=gcp_projects_dag
)

start >> python_task_gcp_projects_to_bq_mrr >> gcpops_dbt_trigger >> end

