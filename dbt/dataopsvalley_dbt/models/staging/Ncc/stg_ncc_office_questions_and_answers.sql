select
    name_of_the_office as office_name,
    office_size,
    topic,
    sub_theme as sub_topic,
    questions,
    answers

from {{ source('src_ncc', 'MRR_Ncc_Office_QuestionsAndAnswers') }}