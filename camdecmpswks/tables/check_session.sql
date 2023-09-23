CREATE TABLE IF NOT EXISTS camdecmpswks.check_session
(
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default",
    test_extension_exemption_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    session_begin_date timestamp without time zone,
    eval_begin_date date,
    eval_end_date date,
    session_end_date timestamp without time zone,
    session_comment character varying(1000) COLLATE pg_catalog."default",
    eval_score_cd character varying(7) COLLATE pg_catalog."default",
    severity_cd character varying(7) COLLATE pg_catalog."default",
    category_cd character varying(7) COLLATE pg_catalog."default",
    process_cd character varying(7) COLLATE pg_catalog."default",
    updated_status_flg character varying(1) COLLATE pg_catalog."default" DEFAULT 'N'::character varying,
    di character varying(50) COLLATE pg_catalog."default",
    last_updated timestamp without time zone,
    userid character varying(160) COLLATE pg_catalog."default",
    batch_id character varying(45) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpswks.check_session
    IS 'Evaluation check sessions.';

COMMENT ON COLUMN camdecmpswks.check_session.chk_session_id
    IS ' Unique identifier of a check session record.';

COMMENT ON COLUMN camdecmpswks.check_session.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmpswks.check_session.test_sum_id
    IS ' Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmpswks.check_session.qa_cert_event_id
    IS ' Unique identifier of a QA certification event record. ';

COMMENT ON COLUMN camdecmpswks.check_session.test_extension_exemption_id
    IS ' Unique identifier of a test extension exemption record. ';

COMMENT ON COLUMN camdecmpswks.check_session.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.check_session.session_begin_date
    IS ' Date and time in which the check session was started.';

COMMENT ON COLUMN camdecmpswks.check_session.session_end_date
    IS ' Date and time in which the check session was ended.';

COMMENT ON COLUMN camdecmpswks.check_session.session_comment
    IS ' Comment related to the check session.';

COMMENT ON COLUMN camdecmpswks.check_session.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpswks.check_session.category_cd
    IS ' Code used to identify the check category.';

COMMENT ON COLUMN camdecmpswks.check_session.process_cd
    IS ' Code used to identify the check process.';

COMMENT ON COLUMN camdecmpswks.check_session.userid
    IS ' User account or source of data that added or updated record.';
