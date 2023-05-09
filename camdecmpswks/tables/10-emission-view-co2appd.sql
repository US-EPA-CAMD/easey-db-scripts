-- Table: camdecmpswks.emission_view_co2appd

-- DROP TABLE camdecmpswks.emission_view_co2appd;

CREATE TABLE camdecmpswks.emission_view_co2appd
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
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_co2appd PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, fuel_type, fuel_sys_id, date_hour),
    CONSTRAINT fk_emission_view_co2appd_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_co2appd_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2appd_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2appd_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);