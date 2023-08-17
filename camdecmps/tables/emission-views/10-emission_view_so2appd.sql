-- Table: camdecmps.emission_view_so2appd

-- DROP TABLE camdecmps.emission_view_so2appd;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_so2appd
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default",
    fuel_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_use_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    calc_fuel_flow numeric(10,1),
    fuel_flow_uom character varying(7) COLLATE pg_catalog."default",
    fuel_flow_sodc character varying(7) COLLATE pg_catalog."default",
    sulfur_content numeric(13,5),
    sulfur_uom character varying(7) COLLATE pg_catalog."default",
    sulfur_sampling_type character varying(7) COLLATE pg_catalog."default",
    default_so2_emission_rate numeric(13,5),
    calc_hi_rate numeric(13,5),
    formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_so2_mass_rate numeric(13,5),
    calc_so2_mass_rate numeric(13,5),
    summation_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_so2_mass_rate_all_fuels numeric(14,4),
    calc_so2_mass_rate_all_fuels numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_so2appd PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, fuel_type, fuel_sys_id, date_hour)
) PARTITION BY RANGE (rpt_period_id);
