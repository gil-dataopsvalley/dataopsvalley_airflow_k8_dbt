from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("0_0_main_yuval_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="0_0_main_yuval_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='triggers yuval EL process DAGs',
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


# Customers:
customers_object_sensor = GCSObjectExistenceSensor(
    task_id='customers_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Yuval/Customers/Yuval_Accounts_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

customers_trigger = TriggerDagRunOperator(
        task_id='trigger_yuval_customers_dag',
        trigger_dag_id='0_1_dag_yuval_customers',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# yuval_customers dbt process
yuval_customers_dbt_trigger = TriggerDagRunOperator(
        task_id='yuval_customers_dbt_trigger',
        trigger_dag_id='0_1_dag_yuval_customers_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Contacts:
contacts_object_sensor = GCSObjectExistenceSensor(
    task_id='contacts_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Yuval/Contacts/YuvalContacts_Accounts_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

contacts_trigger = TriggerDagRunOperator(
        task_id='trigger_yuval_contacts_dag',
        trigger_dag_id='0_1_dag_yuval_contacts',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# yuval_contacts dbt process
yuval_contacts_dbt_trigger = TriggerDagRunOperator(
        task_id='yuval_contacts_dbt_trigger',
        trigger_dag_id='0_1_dag_yuval_contacts_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# # Applications:
# yuval_application_object_sensor = GCSObjectExistenceSensor(
#     task_id='yuval_applications_object_sensor',
#     bucket='govilbi_files',
#     object=f'GovilFromOnPrem/Yuval/yuval_applications/yuval_applications_'
#            f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
#     mode='poke',
#     poke_interval=1800,
#     timeout=86400,
#     dag=main_dag
# )
#
# yuval_applications_trigger = TriggerDagRunOperator(
#         task_id='trigger_yuval_applications_dag',
#         trigger_dag_id='0_1_dag_yuval_applications',
#         wait_for_completion=True,
#         poke_interval=20,
#         trigger_rule='all_success',
#         dag=main_dag
# )
#
#
# # SLA:
# yuval_sla_object_sensor = GCSObjectExistenceSensor(
#     task_id='yuval_sla_object_sensor',
#     bucket='govilbi_files',
#     object=f'GovilFromOnPrem/Yuval/sla_log/sla_log_'
#            f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
#     mode='poke',
#     poke_interval=1800,
#     timeout=86400,
#     dag=main_dag
# )
#
# yuval_sla_trigger = TriggerDagRunOperator(
#         task_id='trigger_yuval_sla_dag',
#         trigger_dag_id='0_1_dag_yuval_sla',
#         wait_for_completion=True,
#         poke_interval=20,
#         trigger_rule='all_success',
#         dag=main_dag
# )


# # Slakpiinstance:
# yuval_slakpiinstance_object_sensor = GCSObjectExistenceSensor(
#     task_id='yuval_slakpiinstance_object_sensor',
#     bucket='govilbi_files',
#     object=f'GovilFromOnPrem/Yuval/Slakpiinstance/loadYuval_slakpiinstance.json',
#     mode='poke',
#     poke_interval=1800,
#     timeout=86400,
#     dag=main_dag
# )
#
# yuval_slakpiinstance_trigger = TriggerDagRunOperator(
#         task_id='trigger_yuval_slakpiinstance_dag',
#         trigger_dag_id='0_1_dag_yuval_slakpiinstance',
#         wait_for_completion=True,
#         poke_interval=20,
#         trigger_rule='all_success',
#         dag=main_dag
# )

# Products:
yuval_products_object_sensor = GCSObjectExistenceSensor(
    task_id='yuval_products_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Yuval/Products/Yuval_Products_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

yuval_products_trigger = TriggerDagRunOperator(
        task_id='trigger_yuval_products_dag',
        trigger_dag_id='0_1_dag_yuval_products',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk Station:
yuval_kiosk_station_object_sensor = GCSObjectExistenceSensor(
    task_id='yuval_kiosk_station_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Yuval/Yuval_Kiosk_Station/Yuval_Kiosk_Station_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

yuval_kiosk_station_trigger = TriggerDagRunOperator(
        task_id='trigger_yuval_kiosk_station_dag',
        trigger_dag_id='0_1_dag_yuval_kiosk_station',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Kiosk Location:
yuval_kiosk_location_object_sensor = GCSObjectExistenceSensor(
    task_id='yuval_kiosk_location_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Yuval/Yuval_kiosk_location/Yuval_kiosk_location_'
           f'{(datetime.today() - timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

yuval_kiosk_location_trigger = TriggerDagRunOperator(
        task_id='trigger_yuval_kiosk_location_dag',
        trigger_dag_id='0_1_dag_yuval_kiosk_location',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


start >> [customers_object_sensor >> customers_trigger >> yuval_customers_dbt_trigger,
          contacts_object_sensor >> contacts_trigger >> yuval_contacts_dbt_trigger,
          # yuval_application_object_sensor >> yuval_applications_trigger,
          # yuval_sla_object_sensor >> yuval_sla_trigger,
          # yuval_slakpiinstance_object_sensor >> yuval_slakpiinstance_trigger,
          yuval_products_object_sensor >> yuval_products_trigger,
          yuval_kiosk_station_object_sensor >> yuval_kiosk_station_trigger,
          yuval_kiosk_location_object_sensor >> yuval_kiosk_location_trigger] >> end


