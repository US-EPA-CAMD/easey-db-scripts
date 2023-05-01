-- Table: camdecmpswks.emission_view_co2dailyfuel

-- DROP TABLE camdecmpswks.emission_view_co2dailyfuel;

CREATE TABLE camdecmpswks.emission_view_co2dailyfuel
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    date date NOT NULL,
    rpt_total_daily_co2_mass numeric(10,1),
    rpt_unadjusted_co2_mass numeric(10,1),
    rpt_adjusted_daily_co2_mass numeric(10,1),
    rpt_sorbent_rltd_co2_mass numeric(10,1),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    fuel_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    daily_fuel_feed numeric(13,1),
    carbon_content_used numeric(5,1),
    fuel_carbon_burned numeric(13,1),
    calc_fuel_carbon_burned numeric(13,1),
    total_carbon_burned numeric(13,1),
    calc_total_daily_emission numeric(10,1),
    CONSTRAINT pk_emission_view_co2dailyfuel PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, fuel_cd, date),
    CONSTRAINT fk_emission_view_co2dailyfuel_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_co2dailyfuel_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2dailyfuel_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_co2dailyfuel_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);