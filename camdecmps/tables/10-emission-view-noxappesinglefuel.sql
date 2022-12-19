-- Table: camdecmps.emission_view_noxappesinglefuel

-- DROP TABLE camdecmps.emission_view_noxappesinglefuel;

CREATE TABLE IF NOT EXISTS camdecmps.emission_view_noxappesinglefuel
(
    em_nox_appe_single_fuel_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default",
    fuel_type character varying(45) COLLATE pg_catalog."default" NOT NULL,
    fuel_use_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(45) COLLATE pg_catalog."default",
    calc_hi_rate numeric(13,5),
    operating_condition_cd character varying(45) COLLATE pg_catalog."default",
    segment_number integer,
    app_e_sys_id character varying(3) COLLATE pg_catalog."default",
    rpt_nox_emission_rate numeric(13,5),
    calc_nox_emission_rate numeric(13,5),
    summation_formula_cd character varying(45) COLLATE pg_catalog."default",
    rpt_nox_emission_rate_all_fuels numeric(14,4),
    calc_nox_emission_rate_all_fuels numeric(14,4),
    calc_hi_rate_all_fuels numeric(14,4),
    nox_mass_rate_formula_cd character varying(45) COLLATE pg_catalog."default",
    rpt_nox_mass_all_fuels numeric(14,4),
    calc_nox_mass_all_fuels numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);