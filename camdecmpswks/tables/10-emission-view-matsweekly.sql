-- Table: camdecmpswks.emission_view_matsweekly

-- DROP TABLE camdecmpswks.emission_view_matsweekly;

CREATE TABLE camdecmpswks.emission_view_matsweekly
(
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id integer NOT NULL,
    weekly_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    system_component_identifier character varying(3) COLLATE pg_catalog."default",
    system_component_type character varying(1000) COLLATE pg_catalog."default",
    date_hour character varying(25) COLLATE pg_catalog."default" NOT NULL,
    test_type character varying(7) COLLATE pg_catalog."default",
    test_result character varying(7) COLLATE pg_catalog."default",
    span_scale character varying(7) COLLATE pg_catalog."default",
    gas_level character varying(7) COLLATE pg_catalog."default",
    ref_value numeric(13,2),
    measured_value numeric(13,3),
    system_integrity_error numeric(5,1),
    error_codes character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_emission_view_matsweekly PRIMARY KEY (mon_plan_id, mon_loc_id, rpt_period_id, weekly_test_sum_id),
    CONSTRAINT fk_emission_view_matsweekly_emission_evaluation FOREIGN KEY (rpt_period_id, mon_plan_id)
        REFERENCES camdecmpswks.emission_evaluation (rpt_period_id, mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_emission_view_matsweekly_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmpswks.monitor_location (mon_loc_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_matsweekly_monitor_plan FOREIGN KEY (mon_plan_id)
        REFERENCES camdecmpswks.monitor_plan (mon_plan_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emission_view_matsweekly_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);