CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_noxappemixedfuel
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    system_id character varying(3) COLLATE pg_catalog."default" NOT NULL,
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
    ERROR_CODES character varying(1) COLLATE pg_catalog."default"
);