CREATE TABLE IF NOT EXISTS camdecmpswks.test_summary
(
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_num character varying(18) COLLATE pg_catalog."default" NOT NULL,
    gp_ind numeric(38,0),
    calc_gp_ind numeric(38,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_reason_cd character varying(7) COLLATE pg_catalog."default",
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0),
    test_description character varying(100) COLLATE pg_catalog."default",
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    calc_span_value numeric(13,3),
    test_comment character varying(1000) COLLATE pg_catalog."default",
    last_updated date,
    updated_status_flg character varying(1) COLLATE pg_catalog."default",
    needs_eval_flg character varying(1) COLLATE pg_catalog."default",
    chk_session_id character varying(45) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    injection_protocol_cd character varying(7) COLLATE pg_catalog."default",
    eval_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'EVAL'::character varying
);