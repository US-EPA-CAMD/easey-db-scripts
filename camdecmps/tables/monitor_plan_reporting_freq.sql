CREATE TABLE IF NOT EXISTS camdecmps.monitor_plan_reporting_freq
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

COMMENT ON TABLE camdecmps.monitor_plan_reporting_freq
    IS 'Frequency of emissions reporting for a monitoring plan.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.mon_plan_rf_id
    IS 'Unique identifier of a monitoring plan reporting frequency record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.report_freq_cd
    IS 'Code that indicates the frequency of data submission. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.end_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.monitor_plan_reporting_freq.update_date
    IS 'Date and time in which record was last updated.';
