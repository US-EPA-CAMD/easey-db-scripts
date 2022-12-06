-- Table: camdecmps.emission_view_noxappemixedfuel

-- DROP TABLE camdecmps.emission_view_noxappemixedfuel;

CREATE TABLE camdecmps.emission_view_noxappemixedfuel
(
    em_nox_appe_mixed_fuel_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    system_id character varying(3) COLLATE pg_catalog."default",
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    calc_hi_rate numeric(14,4),
    operating_condition_cd character varying(7) COLLATE pg_catalog."default",
    segment_number integer,
    rpt_nox_emission_rate numeric(14,4),
    calc_nox_emission_rate numeric(14,4),
    nox_mass_rate_formula_cd character varying(7) COLLATE pg_catalog."default",
    rpt_nox_mass_rate numeric(14,4),
    calc_nox_mass_rate numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);