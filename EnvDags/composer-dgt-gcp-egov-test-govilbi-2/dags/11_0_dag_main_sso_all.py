from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("11_0_main_sso_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="11_0_main_sso_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers SSO EL process DAGs',
    catchup=False,
    max_active_runs=2
)


start = EmptyOperator(
    task_id='start',
    dag=main_dag
)


end = EmptyOperator(
    task_id='end',
    dag=main_dag
)


# SSO By Metric:
sso_by_metric_object_sensor = GCSObjectExistenceSensor(
    task_id='sso_by_metric_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Sso/SSO_ByMetric/SSO_ByMetric_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

sso_by_metric_trigger = TriggerDagRunOperator(
        task_id='trigger_sso_by_metric_dag',
        trigger_dag_id='11_1_dag_sso_by_metric',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# SSO Web Access:
sso_web_access_object_sensor = GCSObjectExistenceSensor(
    task_id='sso_web_access_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Sso/SSO_Web_Access/SSO_Web_Access_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

sso_web_access_trigger = TriggerDagRunOperator(
        task_id='trigger_sso_web_access_dag',
        trigger_dag_id='11_1_dag_sso_web_access',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# SSO Yuval DNS:
sso_yuval_dns_object_sensor = GCSObjectExistenceSensor(
    task_id='sso_yuval_dns_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Sso/SSO_Yuval_Dns/SSO_Yuval_Dns_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

sso_yuval_dns_trigger = TriggerDagRunOperator(
        task_id='trigger_sso_yuval_dns_dag',
        trigger_dag_id='11_1_dag_sso_yuval_dns',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# SSO Count Sessioon Login:
sso_count_session_login_object_sensor = GCSObjectExistenceSensor(
    task_id='sso_count_session_login_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Sso/SSO_count_session_login/SSO_count_session_login_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

sso_count_session_login_trigger = TriggerDagRunOperator(
        task_id='trigger_sso_count_session_login_dag',
        trigger_dag_id='11_1_dag_sso_count_session_login',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# SSO dbt process
sso_dbt_trigger = TriggerDagRunOperator(
        task_id='sso_dbt_trigger',
        trigger_dag_id='11_1_dag_sso_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [sso_by_metric_object_sensor >> sso_by_metric_trigger,
          sso_web_access_object_sensor >> sso_web_access_trigger,
          sso_yuval_dns_object_sensor >> sso_yuval_dns_trigger,
          sso_count_session_login_object_sensor >> sso_count_session_login_trigger]\
          >> sso_dbt_trigger >> end


