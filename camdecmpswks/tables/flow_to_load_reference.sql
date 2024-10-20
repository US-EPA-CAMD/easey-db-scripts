CREATE TABLE IF NOT EXISTS camdecmpswks.flow_to_load_reference
(
    flow_load_ref_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_level_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    avg_ref_method_flow numeric(10,0),
    calc_avg_ref_method_flow numeric(10,0),
    rata_test_num character varying(18) COLLATE pg_catalog."default",
    avg_gross_unit_load numeric(6,0),
    calc_avg_gross_unit_load numeric(6,0),
    ref_flow_load_ratio numeric(6,2),
    calc_ref_flow_load_ratio numeric(6,2),
    avg_hrly_hi_rate numeric(7,1),
    ref_ghr numeric(6,0),
    calc_ref_ghr numeric(6,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    calc_sep_ref_ind numeric(38,0)
);