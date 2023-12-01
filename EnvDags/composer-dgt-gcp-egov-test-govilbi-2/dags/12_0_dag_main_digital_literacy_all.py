from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("12_0_main_digital_literacy_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="12_0_main_digital_literacy_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers Digital Literacy EL process DAGs',
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


# Digital Literacy Kayma:
digital_literacy_kayma_object_sensor = GCSObjectExistenceSensor(
    task_id='digital_literacy_kayma_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DigitalLiteracy/Kayma/DigitalLiteracy_Kayma.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

digital_literacy_kayma_trigger = TriggerDagRunOperator(
        task_id='trigger_digital_literacy_kayma_dag',
        trigger_dag_id='12_1_dag_digital_literacy_kayma',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Digital Literacy Programs:
digital_literacy_programs_object_sensor = GCSObjectExistenceSensor(
    task_id='digital_literacy_programs_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DigitalLiteracy/Programs/DigitalLiteracy_Programs.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

digital_literacy_programs_trigger = TriggerDagRunOperator(
        task_id='trigger_digital_literacy_programs_dag',
        trigger_dag_id='12_1_dag_digital_literacy_programs',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Digital Literacy Rashuiot:
digital_literacy_rashuiot_object_sensor = GCSObjectExistenceSensor(
    task_id='digital_literacy_rashuiot_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DigitalLiteracy/Rashuiot/DigitalLiteracy_Rashuiot.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

digital_literacy_rashuiot_trigger = TriggerDagRunOperator(
        task_id='trigger_digital_literacy_rashuiot_dag',
        trigger_dag_id='12_1_dag_digital_literacy_rashuiot',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Digital Literacy Suppliers:
digital_literacy_suppliers_object_sensor = GCSObjectExistenceSensor(
    task_id='digital_literacy_suppliers_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/DigitalLiteracy/Suppliers/DigitalLiteracy_Suppliers.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

digital_literacy_suppliers_trigger = TriggerDagRunOperator(
        task_id='trigger_digital_literacy_suppliers_dag',
        trigger_dag_id='12_1_dag_digital_literacy_suppliers',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Digital Literacy dbt process
digital_literacy_dbt_trigger = TriggerDagRunOperator(
        task_id='digital_literacy_dbt_trigger',
        trigger_dag_id='12_1_dag_digital_literacy_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [digital_literacy_kayma_object_sensor >> digital_literacy_kayma_trigger,
          digital_literacy_programs_object_sensor >> digital_literacy_programs_trigger,
          digital_literacy_rashuiot_object_sensor >> digital_literacy_rashuiot_trigger,
          digital_literacy_suppliers_object_sensor >> digital_literacy_suppliers_trigger] \
         >> digital_literacy_dbt_trigger >> end


