-- Table: camdecmps.emission_view_matshcl

-- DROP TABLE camdecmps.emission_view_matshcl;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_matshcl
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    mats_load numeric(6,0),
    mats_startup_shutdown character varying(1000) COLLATE pg_catalog."default",
    hcl_conc_value character varying(30) COLLATE pg_catalog."default",
    hcl_conc_modc_cd character varying(7) COLLATE pg_catalog."default",
    hcl_conc_pma numeric(4,1),
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
    hcl_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_hcl_rate character varying(30) COLLATE pg_catalog."default",
    hcl_uom character varying(10) COLLATE pg_catalog."default",
    hcl_modc_cd character varying(7) COLLATE pg_catalog."default",
    error_codes character varying(1000) COLLATE pg_catalog."default",
    calc_hcl_rate character varying(30) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_matshcl PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, date_hour)
) PARTITION BY RANGE (rpt_period_id);