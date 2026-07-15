CREATE TABLE IF NOT EXISTS camd.applic_answers
(
    apd_id numeric(38,0),
    applic_q_id numeric(38,0),
    applic_answer varchar(12),
    loop_seq numeric(1,0),
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    ans_id numeric(38,0) NOT NULL
);
COMMENT ON TABLE camd.applic_answers
    IS 'Stores answers to individual questions for an applicability determination.';
COMMENT ON COLUMN camd.applic_answers.apd_id
    IS 'Applicability determination identity key.';
COMMENT ON COLUMN camd.applic_answers.applic_q_id
    IS 'ID for question in applicability determination wizard.';
COMMENT ON COLUMN camd.applic_answers.applic_answer
    IS 'Applicability determination answer.';
COMMENT ON COLUMN camd.applic_answers.loop_seq
    IS 'Stores processing order for answers provided in APPLICABILITY DETERMINATION.';
COMMENT ON COLUMN camd.applic_answers.add_date
    IS 'Date the record was created.';
COMMENT ON COLUMN camd.applic_answers.ans_id
    IS 'Applicability determination answer identifier.';