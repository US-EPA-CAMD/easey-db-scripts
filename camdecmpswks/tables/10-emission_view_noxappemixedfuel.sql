-- Table: camdecmpswks.emission_view_noxappemixedfuel

-- DROP TABLE camdecmpswks.emission_view_noxappemixedfuel;

CREATE TABLE camdecmpswks.emission_view_noxappemixedfuel
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
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_noxappemixedfuel PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, system_id, date_hour),
    CONSTRAINT fk_emission_view_noxappemixedfuel_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_noxappemixedfuel_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_noxappemixedfuel_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_noxappemixedfuel_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);