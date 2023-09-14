CREATE TABLE IF NOT EXISTS camdecmpswks.monitor_plan_reporting_freq
(
    mon_plan_rf_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default",
    report_freq_cd character varying(7) COLLATE pg_catalog."default",
    end_rpt_period_id numeric(38,0),
    begin_rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);
