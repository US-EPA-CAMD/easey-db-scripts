CREATE TABLE IF NOT EXISTS camdecmpswks.flow_to_load_check
(
    flow_load_check_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_basis_cd character varying(7) COLLATE pg_catalog."default",
    avg_abs_pct_diff numeric(5,1),
    num_hrs numeric(4,0),
    nhe_fuel numeric(4,0),
    nhe_ramping numeric(4,0),
    nhe_bypass numeric(4,0),
    nhe_pre_rata numeric(4,0),
    nhe_test numeric(4,0),
    nhe_main_bypass numeric(4,0),
    bias_adjusted_ind numeric(38,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    op_level_cd character varying(7) COLLATE pg_catalog."default"
);