-- Table: camdecmpswks.emission_view_co2cems

-- DROP TABLE camdecmpswks.emission_view_co2cems;

CREATE TABLE camdecmpswks.emission_view_co2cems
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    op_time numeric(3,2),
    unit_load numeric(6,0),
    load_uom character varying(7) COLLATE pg_catalog."default",
    component_type character varying(3) COLLATE pg_catalog."default",
    rpt_pct_co2 numeric(14,4),
    pct_co2_used numeric(5,1),
    co2_modc character varying(7) COLLATE pg_catalog."default",
    co2_pma numeric(4,1),
    unadj_flow numeric(13,3),
    calc_flow_baf numeric(5,3),
    rpt_adj_flow numeric(13,3),
    adj_flow_used numeric(13,3),
    flow_modc character varying(45) COLLATE pg_catalog."default",
    flow_pma numeric(4,1),
    pct_h2o_used numeric(5,1),
    source_h2o_value character varying(7) COLLATE pg_catalog."default",
    co2_formula_cd character varying(45) COLLATE pg_catalog."default",
    rpt_co2_mass_rate numeric(14,4),
    calc_co2_mass_rate numeric(14,4),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_co2cems PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, date_hour),
    CONSTRAINT fk_emission_view_co2cems_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_co2cems_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2cems_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2cems_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);