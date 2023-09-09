CREATE TABLE IF NOT EXISTS camdecmps.weekly_test_summary
(
    weekly_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default",
    component_id character varying(45) COLLATE pg_catalog."default",
    test_date date NOT NULL,
    test_hour numeric(2,0) NOT NULL,
    test_min numeric(2,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_result_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_weekly_test_summary PRIMARY KEY (weekly_test_sum_id),
    CONSTRAINT fk_weekly_test_summary_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_span_scale_code FOREIGN KEY (span_scale_cd)
        REFERENCES camdecmpsmd.span_scale_code (span_scale_cd) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_test_result_code_calc FOREIGN KEY (calc_test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    CONSTRAINT fk_weekly_test_summary_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.weekly_test_summary
    IS 'Summary of weekly calibration test results and weekly interference check results.';

COMMENT ON COLUMN camdecmps.weekly_test_summary.weekly_test_sum_id
    IS 'Unique identifier of a weekly test summary record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_date
    IS 'Date of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_hour
    IS 'Hour of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_min
    IS 'Minute of the weekly test. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.calc_test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.weekly_test_summary.update_date
    IS 'Date and time in which record was last updated. ';
