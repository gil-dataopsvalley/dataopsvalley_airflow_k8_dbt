from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("18_0_main_evc_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="18_0_main_evc_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers Evc EL process DAGs',
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


# Evc Ironswords Roots:
evc_ironswords_roots_object_sensor = GCSObjectExistenceSensor(
    task_id='evc_ironswords_roots_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Evc/Ironswords_Roots/Evc_Ironswords_Roots_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

evc_ironswords_roots_trigger = TriggerDagRunOperator(
        task_id='trigger_evc_ironswords_roots_dag',
        trigger_dag_id='18_1_dag_evc_ironswords_roots',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Evc Ironswords Relative R_List:
evc_ironswords_relative_r_list_object_sensor = GCSObjectExistenceSensor(
    task_id='evc_ironswords_relative_r_list_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Evc/Ironswords_relativeRList/Evc_Ironswords_relativeRList_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

evc_ironswords_relative_r_list_trigger = TriggerDagRunOperator(
        task_id='trigger_evc_ironswords_relative_r_list_dag',
        trigger_dag_id='18_1_dag_evc_ironswords_relative_r_list',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Evc Absorption and Immigration Roots:
evc_ironswords_absorption_and_immigration_roots_object_sensor = GCSObjectExistenceSensor(
    task_id='evc_ironswords_absorption_and_immigration_roots_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Evc/ironswordsAbsorptionAndImmigration_Roots/Evc_ironswordsAbsorptionAndImmigration_Roots_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=600,
    timeout=3600,
    dag=main_dag
)

evc_ironswords_absorption_and_immigration_roots_trigger = TriggerDagRunOperator(
        task_id='trigger_evc_ironswords_absorption_and_immigration_roots_dag',
        trigger_dag_id='18_1_dag_evc_ironswords_absorption_and_immigration_roots',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

#
# # Evc dbt process
# evc_dbt_trigger = TriggerDagRunOperator(
#         task_id='evc_dbt_trigger',
#         trigger_dag_id='18_1_dag_evc_dbt',
#         wait_for_completion=True,
#         poke_interval=20,
#         trigger_rule='all_success',
#         dag=main_dag
# )

start >> [evc_ironswords_roots_object_sensor >> evc_ironswords_roots_trigger,
          evc_ironswords_relative_r_list_object_sensor >> evc_ironswords_relative_r_list_trigger,
          evc_ironswords_absorption_and_immigration_roots_object_sensor >>
          evc_ironswords_absorption_and_immigration_roots_trigger] >> end



