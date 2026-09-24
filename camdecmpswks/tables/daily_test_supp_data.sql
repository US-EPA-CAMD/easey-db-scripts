CREATE TABLE IF NOT EXISTS camdecmpswks.daily_test_supp_data
(
    daily_test_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    component_id character varying(45) COLLATE pg_catalog."default",
    rpt_period_id numeric(38,0) NOT NULL,
    test_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    span_scale_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    key_online_ind numeric(1,0) NOT NULL,
    key_valid_ind numeric(1,0) NOT NULL,
    op_hour_cnt numeric(38,0),
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    daily_test_datehourmin timestamp without time zone,
    test_result_cd character varying(7) COLLATE pg_catalog."default",
    online_offline_ind numeric(38,0),
    sort_daily_test_datehourmin timestamp without time zone,
    daily_test_sum_id character varying(45) COLLATE pg_catalog."default",
    calc_test_result_cd character varying(7) COLLATE pg_catalog."default",
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    delete_ind numeric(1,0) NOT NULL DEFAULT 0,
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmpswks.daily_test_supp_data
    IS 'Supports initializing the daily calibration object with data from the previous quarter.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.component_id
    IS 'Unique identifier of a component record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period recor.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.test_type_cd
    IS 'Code used to identify test type.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.span_scale_cd
    IS 'Code used to identify the span scale.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.key_online_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.key_valid_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.op_hour_cnt
    IS 'Count of hours in the quarter for the component and operating supplemental data type.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.first_op_after_nonop_datehour
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.online_offline_ind
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.sort_daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.daily_test_sum_id
    IS 'Unique identifier of a daily test summary record. .';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.calc_test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpswks.daily_test_supp_data.update_date
    IS 'Date and time in which record was last updated.';
