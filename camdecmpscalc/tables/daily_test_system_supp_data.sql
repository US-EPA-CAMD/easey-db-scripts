CREATE TABLE IF NOT EXISTS camdecmpscalc.daily_test_system_supp_data
(
    pk character varying(45) COLLATE pg_catalog."default" NOT NULL DEFAULT uuid_generate_v4(),
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    key_online_ind numeric(1,0) NOT NULL,
    key_valid_ind numeric(1,0) NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_hour_cnt numeric(38,0) NOT NULL,
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL
);
