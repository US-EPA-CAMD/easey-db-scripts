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
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
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
