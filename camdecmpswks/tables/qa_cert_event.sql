CREATE TABLE IF NOT EXISTS camdecmpswks.qa_cert_event
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
    pending_status_cd character varying(7) COLLATE pg_catalog."default",
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying
);