-- Table: camdecmps.emission_view_all

-- DROP TABLE camdecmps.emission_view_all;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_all
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default",
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    hi_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_hi_rate numeric(14,4),
    calc_hi_rate numeric(14,4),
    so2_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_so2_mass_rate numeric(14,4),
    calc_so2_mass_rate numeric(14,4),
    nox_rate_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_adj_nox_rate numeric(14,4),
    calc_adj_nox_rate numeric(14,4),
    nox_mass_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_nox_mass numeric(14,4),
    calc_nox_mass numeric(14,4),
    co2_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_co2_mass_rate numeric(14,4),
    calc_co2_mass_rate numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    adj_flow_used numeric(13,3),
    rpt_adj_flow numeric(13,3),
    unadj_flow numeric(13,3),
    CONSTRAINT pk_emission_view_all PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, date_hour)
) PARTITION BY RANGE (rpt_period_id);
