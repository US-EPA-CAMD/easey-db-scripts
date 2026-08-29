CREATE TABLE IF NOT EXISTS camdeasey.monitor_plan_reporting_freq
(
    mon_plan_rf_id varchar(45) NOT NULL,
    mon_plan_id varchar(45),
    report_freq_cd varchar(7),
    end_rpt_period_id numeric(38,0),
    begin_rpt_period_id numeric(38,0),
    PRIMARY KEY (mon_plan_rf_id)
);
COMMENT ON TABLE camdeasey.monitor_plan_reporting_freq
    IS 'Frequency of emissions reporting for a monitoring plan.';
COMMENT ON COLUMN camdeasey.monitor_plan_reporting_freq.mon_plan_rf_id
    IS 'Unique identifier of a monitoring plan reporting frequency record. ';
COMMENT ON COLUMN camdeasey.monitor_plan_reporting_freq.mon_plan_id
    IS 'Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.monitor_plan_reporting_freq.report_freq_cd
    IS 'Code that indicates the frequency of data submission. ';
COMMENT ON COLUMN camdeasey.monitor_plan_reporting_freq.end_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.monitor_plan_reporting_freq.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record. ';