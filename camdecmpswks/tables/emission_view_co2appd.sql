CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_co2appd
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default" NOT NULL,
    fuel_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_use_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    calc_hi_rate numeric(13,5),
    fc_factor numeric(13,5),
    formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_co2_mass_rate numeric(13,5),
    calc_co2_mass_rate numeric(13,5),
    summation_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_co2_mass_rate_all_fuels numeric(14,4),
    calc_co2_mass_rate_all_fuels numeric(14,4),
    ERROR_CODES character varying(1) COLLATE pg_catalog."default"
);