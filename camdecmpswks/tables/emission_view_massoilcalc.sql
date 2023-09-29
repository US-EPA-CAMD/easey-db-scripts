CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_massoilcalc
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default" NOT NULL,
    oil_type character varying(7) COLLATE pg_catalog."default" NOT NULL,
    fuel_use_time numeric(3,2),
    rpt_volumetric_oil_flow numeric(10,1),
    calc_volumetric_oil_flow numeric(10,1),
    volumetric_oil_flow_uom character varying(7) COLLATE pg_catalog."default",
    volumetric_oil_flow_sodc character varying(7) COLLATE pg_catalog."default",
    oil_density numeric(13,5),
    oil_density_uom character varying(7) COLLATE pg_catalog."default",
    oil_density_sampling_type character varying(7) COLLATE pg_catalog."default",
    rpt_mass_oil_flow numeric(10,1),
    calc_mass_oil_flow numeric(10,1),
    error_codes character varying(1000) COLLATE pg_catalog."default"
);