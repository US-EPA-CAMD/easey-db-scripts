-- Table: camdecmpswks.emission_view_massoilcalc

-- DROP TABLE camdecmpswks.emission_view_massoilcalc;

CREATE TABLE IF NOT EXISTS camdecmpswks.emission_view_massoilcalc
(
    em_mass_oil_calc_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    fuel_sys_id character varying(3) COLLATE pg_catalog."default",
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
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_massoilcalc PRIMARY KEY (em_mass_oil_calc_id),
    CONSTRAINT fk_emission_view_massoilcalc_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_massoilcalc_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
);