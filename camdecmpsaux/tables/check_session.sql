CREATE TABLE IF NOT EXISTS camdecmpsaux.check_session
(
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    session_begin_date timestamp without time zone,
    session_end_date timestamp without time zone,
    session_comment character varying(1000) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    severity_cd character varying(7) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    category_cd character varying(7) COLLATE pg_catalog."default",
    process_cd character varying(7) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    submission_id double precision
);

COMMENT ON TABLE camdecmpsaux.check_session
    IS 'Evaluation check sessions.';

COMMENT ON COLUMN camdecmpsaux.check_session.chk_session_id
    IS ' Unique identifier of a check session record.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_begin_date
    IS ' Date and time in which the check session was started.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_end_date
    IS ' Date and time in which the check session was ended.';

COMMENT ON COLUMN camdecmpsaux.check_session.session_comment
    IS ' Comment related to the check session.';

COMMENT ON COLUMN camdecmpsaux.check_session.userid
    IS ' User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.check_session.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsaux.check_session.qa_cert_event_id
    IS ' Unique identifier of a QA certification event record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.test_extension_exemption_id
    IS ' Unique identifier of a test extension exemption record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpsaux.check_session.process_cd
    IS ' Code used to identify the check process.';

COMMENT ON COLUMN camdecmpsaux.check_session.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.test_sum_id
    IS ' Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmpsaux.check_session.submission_id
    IS ' Unique identifier of a submission.';
