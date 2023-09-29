CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_plan
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fac_id numeric(38,0) NOT NULL,
    config_type_cd character varying(7) COLLATE pg_catalog."default",
    last_updated timestamp without time zone,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default" DEFAULT 'Y'::character varying,
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    submission_id numeric(38,0),
    submission_availability_cd character varying(7) COLLATE pg_catalog."default" DEFAULT 'GRANTED'::character varying,
    pending_status_cd character varying(7) COLLATE pg_catalog."default",
    begin_rpt_period_id numeric(38,0) NOT NULL,
    end_rpt_period_id numeric(38,0),
    last_evaluated_date timestamp without time zone,
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying
);
