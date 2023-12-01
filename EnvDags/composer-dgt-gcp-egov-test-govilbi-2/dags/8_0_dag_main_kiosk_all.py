from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("8_0_main_kiosk_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="8_0_main_kiosk_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='triggers kiosk EL process DAGs',
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


# Kiosk Languages:
kiosk_languages_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_languages_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/Languages/Kiosk_Languages_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_languages_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_languages_dag',
        trigger_dag_id='8_1_dag_kiosk_languages',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Kiosk Offices:
kiosk_offices_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_offices_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/Offices/Kiosk_Offices_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_offices_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_offices_dag',
        trigger_dag_id='8_1_dag_kiosk_offices',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Kiosk ServiceTypeToService:
kiosk_service_type_to_service_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_service_type_to_service_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/ServiceTypeToService/Kiosk_ServiceTypeToService_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_service_type_to_service_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_service_type_to_service_dag',
        trigger_dag_id='8_1_dag_kiosk_service_type_to_service',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Kiosk Services:
kiosk_services_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_services_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/Services/Kiosk_Services_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_services_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_services_dag',
        trigger_dag_id='8_1_dag_kiosk_services',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Kiosk Stations:
kiosk_stations_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_stations_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/Stations/Kiosk_Stations_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_stations_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_stations_dag',
        trigger_dag_id='8_1_dag_kiosk_stations',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk StationsServices:
kiosk_stations_services_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_stations_services_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/StationsServices/Kiosk_StationsServices_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_stations_services_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_stations_services_dag',
        trigger_dag_id='8_1_dag_kiosk_stations_services',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk Log Daily_h:
kiosk_log_daily_h_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_log_daily_h_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/Kiosk_Log_Daily_H/KioskLog_Daily_H_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_log_daily_h_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_log_daily_h_dag',
        trigger_dag_id='8_1_dag_kiosk_log_daily_h',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk Service Language:
kiosk_service_language_object_sensor = GCSObjectExistenceSensor(
    task_id='kiosk_service_language_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Kiosk/ServiceLanguage/Kiosk_ServiceLanguage_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

kiosk_service_language_trigger = TriggerDagRunOperator(
        task_id='trigger_kiosk_service_language_dag',
        trigger_dag_id='8_1_dag_kiosk_service_language',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk dbt process
kiosk_dbt_trigger = TriggerDagRunOperator(
        task_id='kiosk_dbt_trigger',
        trigger_dag_id='8_1_dag_kiosk_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [kiosk_languages_object_sensor >> kiosk_languages_trigger,
          kiosk_offices_object_sensor >> kiosk_offices_trigger,
          kiosk_service_type_to_service_object_sensor >> kiosk_service_type_to_service_trigger,
          kiosk_services_object_sensor >> kiosk_services_trigger,
          kiosk_stations_object_sensor >> kiosk_stations_trigger,
          kiosk_stations_services_object_sensor >> kiosk_stations_services_trigger,
          kiosk_log_daily_h_object_sensor >> kiosk_log_daily_h_trigger,
          kiosk_service_language_object_sensor >> kiosk_service_language_trigger] \
         >> kiosk_dbt_trigger >> end


