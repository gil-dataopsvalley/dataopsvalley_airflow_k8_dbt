from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.empty import EmptyOperator
from airflow.operators.trigger_dagrun import TriggerDagRunOperator
from airflow.providers.google.cloud.sensors.gcs import GCSObjectExistenceSensor
from airflow.models import Variable

today = datetime.today()-timedelta(days=1)
schedule_param = Variable.get("17_0_main_emon_schedule_interval")

default_args = {
    "owner": "airflow",
    "email": "avigailg@digital.com",
    "email_on_failure": True,
    "retries": 1,
    "retry_delay": timedelta(minutes=10)
}


main_dag = DAG(
    dag_id="17_0_main_emon_trigger_dag",
    default_args=default_args,
    schedule_interval=f'{schedule_param}',
    start_date=datetime(today.year, today.month, today.day),
    description='Triggers Emon EL process DAGs',
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

# Emon District:
emon_district_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_district_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/District/Emon_District_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_district_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_district_dag',
        trigger_dag_id='17_1_dag_emon_district',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Education Institution Type:
emon_education_institution_type_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_education_institution_type_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EducationInstitutionType/Emon_EducationInstitutionType_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_education_institution_type_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_education_institution_type_dag',
        trigger_dag_id='17_1_dag_emon_education_institution_type',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Education Sector:
emon_education_sector_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_education_sector_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EducationSector/Emon_EducationSector_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_education_sector_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_education_sector_dag',
        trigger_dag_id='17_1_dag_emon_education_sector',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Education Supervision:
emon_education_supervision_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_education_supervision_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EducationSupervision/Emon_EducationSupervision_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_education_supervision_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_education_supervision_dag',
        trigger_dag_id='17_1_dag_emon_education_supervision',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Education Type:
emon_education_type_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_education_type_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EducationType/Emon_EducationType_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_education_type_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_education_type_dag',
        trigger_dag_id='17_1_dag_emon_education_type',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Educator:
emon_educator_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_educator_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/Educator/Emon_Educator_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_educator_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_educator_dag',
        trigger_dag_id='17_1_dag_emon_educator',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Educator Type:
emon_educator_type_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_educator_type_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EducatorType/Emon_EducatorType_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_educator_type_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_educator_type_dag',
        trigger_dag_id='17_1_dag_emon_educator_type',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Evacuation Status:
emon_evacuation_status_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_evacuation_status_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/EvacuationStatus/Emon_EvacuationStatus_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_evacuation_status_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_evacuation_status_dag',
        trigger_dag_id='17_1_dag_emon_evacuation_status',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Institution:
emon_institution_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_institution_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/Institution/Emon_Institution_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_institution_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_institution_dag',
        trigger_dag_id='17_1_dag_emon_institution',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Institution Numbers:
emon_institution_numbers_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_institution_numbers_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/InstitutionNumbers/Emon_InstitutionNumbers_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_institution_numbers_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_institution_numbers_dag',
        trigger_dag_id='17_1_dag_emon_institution_numbers',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Medical Status:
emon_medical_status_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_medical_status_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/MedicalStatus/Emon_MedicalStatus_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_medical_status_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_medical_status_dag',
        trigger_dag_id='17_1_dag_emon_medical_status',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon OpCl:
emon_op_cl_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_op_cl_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/OpCl/Emon_OpCl_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_op_cl_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_op_cl_dag',
        trigger_dag_id='17_1_dag_emon_op_cl',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Place Sub Types:
emon_place_sub_types_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_place_sub_types_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/PlaceSubTypes/Emon_PlaceSubTypes_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_place_sub_types_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_place_sub_types_dag',
        trigger_dag_id='17_1_dag_emon_place_sub_types',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Place Types:
emon_place_types_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_place_types_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/PlaceTypes/Emon_PlaceTypes_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_place_types_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_place_types_dag',
        trigger_dag_id='17_1_dag_emon_place_types',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Settelment:
emon_settelment_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_settelment_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/Settelment/Emon_Settelment_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_settelment_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_settelment_dag',
        trigger_dag_id='17_1_dag_emon_settelment',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon Work Status:
emon_work_status_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_work_status_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/WorkStatus/Emon_WorkStatus_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_work_status_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_work_status_dag',
        trigger_dag_id='17_1_dag_emon_work_status',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

# Emon kindergartens:
emon_kindergartens_object_sensor = GCSObjectExistenceSensor(
    task_id='emon_kindergartens_object_sensor',
    bucket='govilbi_files',
    object=f'GovilFromOnPrem/Emon/kindergartens/Emon_kindergartens_'
           f'{(datetime.today()-timedelta(days=1)).strftime("%Y%m%d")}.json',
    mode='poke',
    poke_interval=1800,
    timeout=86400,
    dag=main_dag
)

emon_kindergartens_trigger = TriggerDagRunOperator(
        task_id='trigger_emon_kindergartens_dag',
        trigger_dag_id='17_1_dag_emon_kindergartens',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)


# Emon dbt process
emon_dbt_trigger = TriggerDagRunOperator(
        task_id='emon_dbt_trigger',
        trigger_dag_id='17_1_dag_emon_dbt',
        wait_for_completion=True,
        poke_interval=20,
        trigger_rule='all_success',
        dag=main_dag
)

start >> [emon_district_object_sensor >> emon_district_trigger,
          emon_education_institution_type_object_sensor >> emon_education_institution_type_trigger,
          emon_education_sector_object_sensor >> emon_education_sector_trigger,
          emon_education_supervision_object_sensor >> emon_education_supervision_trigger,
          emon_education_type_object_sensor >> emon_education_type_trigger,
          emon_educator_object_sensor >> emon_educator_trigger,
          emon_educator_type_object_sensor >> emon_educator_type_trigger,
          emon_evacuation_status_object_sensor >> emon_evacuation_status_trigger,
          emon_institution_object_sensor >> emon_institution_trigger,
          emon_institution_numbers_object_sensor >> emon_institution_numbers_trigger,
          emon_medical_status_object_sensor >> emon_medical_status_trigger,
          emon_op_cl_object_sensor >> emon_op_cl_trigger,
          emon_place_sub_types_object_sensor >> emon_place_sub_types_trigger,
          emon_place_types_object_sensor >> emon_place_types_trigger,
          emon_settelment_object_sensor >> emon_settelment_trigger,
          emon_work_status_object_sensor >> emon_work_status_trigger,
          emon_kindergartens_object_sensor >> emon_kindergartens_trigger] \
         >> emon_dbt_trigger >> end


