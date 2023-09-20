CREATE TABLE IF NOT EXISTS camdecmps.qa_cert_event
(
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    qa_cert_event_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    qa_cert_event_date date NOT NULL,
    qa_cert_event_hour numeric(2,0) NOT NULL,
    required_test_cd character varying(7) COLLATE pg_catalog."default",
    conditional_data_begin_date date,
    conditional_data_begin_hour numeric(2,0),
    last_test_completed_date date,
    last_test_completed_hour numeric(2,0),
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    qa_cert_event_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default",
    resub_explanation character varying(4000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmps.qa_cert_event
    IS 'Maintenance, certification and recertification events.  Record Type 556.';

COMMENT ON COLUMN camdecmps.qa_cert_event.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_cd
    IS 'Code used to identify QA and certification event. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_date
    IS 'Date on which the QA Cert Event occurred. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_hour
    IS 'Hour in which the QA Cert Event occurred. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.required_test_cd
    IS 'Code used to identify the test(s) required due to the event. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.conditional_data_begin_date
    IS 'Date on which conditional data validation began based on completion of a successful daily calibration. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.conditional_data_begin_hour
    IS 'Hour in which conditional data validation began based on completion of a successful daily calibration. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_test_completed_date
    IS 'Date in which the last test was completed. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_test_completed_hour
    IS 'Hour in which last test was completed. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.last_updated
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.updated_status_flg
    IS 'If set to true, identifies that changes have been made to the QA certification event data from within the client tool, consequently data must be submitted to the Host. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.needs_eval_flg
    IS 'Identifies whether the data need to have checks run against it. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.chk_session_id
    IS 'Identifies the most recent check session used for the evaluation. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.qa_cert_event.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.qa_cert_event.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.qa_cert_event.qa_cert_event_id
    IS 'Unique identifier of an QA certification event record. ';

COMMENT ON COLUMN camdecmps.qa_cert_event.submission_id
    IS 'Unique identifier of a submission.';

COMMENT ON COLUMN camdecmps.qa_cert_event.submission_availability_cd
    IS 'Unique code value for a lookup table.';
