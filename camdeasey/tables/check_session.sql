CREATE TABLE IF NOT EXISTS camdeasey.check_session
(
    chk_session_id varchar(45) NOT NULL,
    session_begin_date timestamp without time zone,
    session_end_date timestamp without time zone,
    session_comment varchar(1000),
    userid varchar(160),
    mon_plan_id varchar(45),
    severity_cd varchar(7),
    qa_cert_event_id varchar(45),
    test_extension_exemption_id varchar(45),
    category_cd varchar(7),
    process_cd varchar(7),
    rpt_period_id numeric(38,0),
    test_sum_id varchar(45),
    submission_id numeric,
    PRIMARY KEY (chk_session_id)
);
COMMENT ON TABLE camdeasey.check_session
    IS 'Evaluation check sessions.';
COMMENT ON COLUMN camdeasey.check_session.chk_session_id
    IS ' Unique identifier of a check session record.';
COMMENT ON COLUMN camdeasey.check_session.session_begin_date
    IS ' Date and time in which the check session was started.';
COMMENT ON COLUMN camdeasey.check_session.session_end_date
    IS ' Date and time in which the check session was ended.';
COMMENT ON COLUMN camdeasey.check_session.session_comment
    IS ' Comment related to the check session.';
COMMENT ON COLUMN camdeasey.check_session.userid
    IS ' User account or source of data that added or updated record.';
COMMENT ON COLUMN camdeasey.check_session.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.check_session.severity_cd
    IS ' Code used to identify the severity of the check result.';
COMMENT ON COLUMN camdeasey.check_session.qa_cert_event_id
    IS ' Unique identifier of a QA certification event record. ';
COMMENT ON COLUMN camdeasey.check_session.test_extension_exemption_id
    IS ' Unique identifier of a test extension exemption record. ';
COMMENT ON COLUMN camdeasey.check_session.category_cd
    IS ' Code used to identify the check category.';
COMMENT ON COLUMN camdeasey.check_session.process_cd
    IS ' Code used to identify the check process.';
COMMENT ON COLUMN camdeasey.check_session.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.check_session.test_sum_id
    IS ' Unique identifier of a test summary record. ';
COMMENT ON COLUMN camdeasey.check_session.submission_id
    IS ' Unique identifier of a submission.';