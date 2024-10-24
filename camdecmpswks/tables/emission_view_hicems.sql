CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_hicems
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    load_range integer,
    common_stack_load_range integer,
    hi_formula_cd character varying(7) COLLATE pg_catalog."default",
    hi_modc character varying(7) COLLATE pg_catalog."default",
    rpt_hi_rate numeric(14,4),
    calc_hi_rate numeric(14,4),
    diluent_param character varying(3) COLLATE pg_catalog."default",
    rpt_pct_diluent numeric(13,3),
    pct_diluent_used numeric(5,1),
    diluent_modc character varying(7) COLLATE pg_catalog."default",
    diluent_pma numeric(4,1),
    unadj_flow numeric(13,3),
    calc_flow_baf numeric(5,3),
    rpt_adj_flow numeric(13,3),
    adj_flow_used numeric(13,3),
    flow_modc character varying(7) COLLATE pg_catalog."default",
    flow_pma numeric(4,1),
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    f_factor numeric(8,1),
    ERROR_CODES character varying(1) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default"
);