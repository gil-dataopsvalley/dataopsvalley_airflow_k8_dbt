select
    office_name,
    office_size,
    topic,
    sub_topic,
    questions,
    answers
from {{ ref('stg_ncc_office_questions_and_answers') }}