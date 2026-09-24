CREATE TABLE IF NOT EXISTS camdecmpswks.daily_test_summary
(
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default",
    daily_test_date date NOT NULL,
    daily_test_hour numeric(2,0) NOT NULL,
    daily_test_min numeric(2,0),
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    test_result_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    span_scale_cd character varying(7) COLLATE pg_catalog."default",
    mon_sys_id character varying(45) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpswks.daily_test_summary
    IS 'Summary of daily calibration test results and daily interference check results.';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.daily_test_sum_id
    IS 'Unique identifier of a daily test summary record. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.rpt_period_id
    IS 'Unique identifier of a reporting period record. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.mon_loc_id
    IS 'Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.component_id
    IS 'Unique identifier of a monitoring component record. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.daily_test_date
    IS 'Date of the daily test. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.daily_test_hour
    IS 'Hour of the daily test. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.daily_test_min
    IS 'Minute of the daily test. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.test_type_cd
    IS 'Code used to identify test type. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.calc_test_result_cd
    IS 'Code used to identify reported test result. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.update_date
    IS 'Date and time in which record was last updated. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.span_scale_cd
    IS 'Code used to identify the span scale. ';

COMMENT ON COLUMN camdecmpswks.daily_test_summary.mon_sys_id
    IS 'Unique identifier of a monitoring system record. ';
