-- Table: camdecmps.emission_view_lme

-- DROP TABLE camdecmps.emission_view_lme;

CREATE TABLE camdecmps.emission_view_lme
(
    em_lme_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    hour_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    hi_modc character varying(7) COLLATE pg_catalog."default",
    rpt_heat_input numeric(14,4),
    calc_heat_input numeric(14,4),
    so2m_fuel_type character varying(7) COLLATE pg_catalog."default",
    so2_emiss_rate numeric(15,4),
    rpt_so2_mass numeric(14,4),
    calc_so2_mass numeric(14,4),
    noxm_fuel_type character varying(7) COLLATE pg_catalog."default",
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    nox_emiss_rate numeric(15,4),
    rpt_nox_mass numeric(14,4),
    calc_nox_mass numeric(14,4),
    co2m_fuel_type character varying(7) COLLATE pg_catalog."default",
    co2_emiss_rate numeric(15,4),
    rpt_co2_mass numeric(14,4),
    calc_co2_mass numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);