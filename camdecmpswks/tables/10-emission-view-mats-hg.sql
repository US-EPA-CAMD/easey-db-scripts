-- Table: camdecmpswks.emission_view_mats_hg

-- DROP TABLE camdecmpswks.emission_view_mats_hg;

CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_mats_hg
(
    em_mats_hg_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    mats_load numeric(6,0),
    mats_startup_shutdown character varying(1000) COLLATE pg_catalog."default",
    hg_conc_value character varying(30) COLLATE pg_catalog."default",
    hg_conc_system_id character varying(3) COLLATE pg_catalog."default",
    hg_conc_sys_type character varying(1000) COLLATE pg_catalog."default",
    hg_conc_modc_cd character varying(7) COLLATE pg_catalog."default",
    hg_conc_pma numeric(4,1),
    sampling_train_comp_id1 character varying(3) COLLATE pg_catalog."default",
    gas_flowmeter_reading1 numeric(13,3),
    ratio_stack_gas_flow_rate1 numeric(4,1),
    sampling_train_comp_id2 character varying(3) COLLATE pg_catalog."default",
    gas_flowmeter_reading2 numeric(13,3),
    ratio_stack_gas_flow_rate2 numeric(4,1),
    flow_rate character varying(30) COLLATE pg_catalog."default",
    flow_modc character varying(7) COLLATE pg_catalog."default",
    flow_pma numeric(4,1),
    rpt_pct_diluent character varying(30) COLLATE pg_catalog."default",
    diluent_parameter character varying(8) COLLATE pg_catalog."default",
    calc_pct_diluent numeric(5,1),
    diluent_modc character varying(7) COLLATE pg_catalog."default",
    calc_pct_h2o numeric(5,1),
    h2o_source character varying(7) COLLATE pg_catalog."default",
    f_factor numeric(8,1),
    hg_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_hg_rate character varying(30) COLLATE pg_catalog."default",
    hg_uom character varying(10) COLLATE pg_catalog."default",
    hg_modc_cd character varying(7) COLLATE pg_catalog."default",
    error_codes character varying(1000) COLLATE pg_catalog."default",
    calc_hg_rate character varying(30) COLLATE pg_catalog."default"
);