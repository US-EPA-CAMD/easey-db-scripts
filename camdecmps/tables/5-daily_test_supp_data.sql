CREATE TABLE IF NOT EXISTS camdecmps.daily_test_supp_data
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
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_daily_test_supp_data PRIMARY KEY (daily_test_supp_data_id),
    CONSTRAINT fk_daily_test_supp_data_component FOREIGN KEY (component_id)
        REFERENCES camdecmps.component (component_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_supp_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_supp_data_test_result_code FOREIGN KEY (test_result_cd)
        REFERENCES camdecmpsmd.test_result_code (test_result_cd) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_supp_data_test_type_code FOREIGN KEY (test_type_cd)
        REFERENCES camdecmpsmd.test_type_code (test_type_cd) MATCH SIMPLE,
    CONSTRAINT ck_daily_test_supp_data_cmp CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND component_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND component_id IS NULL),
    CONSTRAINT ck_daily_test_supp_data_dti CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_sum_id IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_sum_id IS NULL),
    CONSTRAINT ck_daily_test_supp_data_dtt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND daily_test_datehourmin IS NULL),
    CONSTRAINT ck_daily_test_supp_data_ohc CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND op_hour_cnt IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND op_hour_cnt IS NULL),
    CONSTRAINT ck_daily_test_supp_data_ssc CHECK (span_scale_cd::text = ANY (ARRAY['H'::character varying, 'L'::character varying, 'N'::character varying]::text[])),
    CONSTRAINT ck_daily_test_supp_data_stt CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND sort_daily_test_datehourmin IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND sort_daily_test_datehourmin IS NULL),
    CONSTRAINT ck_daily_test_supp_data_trs CHECK (COALESCE(delete_ind, 0::numeric) <> 1::numeric AND test_result_cd IS NOT NULL OR COALESCE(delete_ind, 0::numeric) = 1::numeric AND test_result_cd IS NULL)
);

COMMENT ON TABLE camdecmps.daily_test_supp_data
    IS 'Supports initializing the daily calibration object with data from the previous quarter.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.daily_test_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.component_id
    IS 'Unique identifier of a component record.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.rpt_period_id
    IS 'Unique identifier of a reporting period recor.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.test_type_cd
    IS 'Code used to identify test type.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.span_scale_cd
    IS 'Code used to identify the span scale.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.key_online_ind
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.key_valid_ind
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.op_hour_cnt
    IS 'Count of hours in the quarter for the component and operating supplemental data type.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.first_op_after_nonop_datehour
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.online_offline_ind
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.sort_daily_test_datehourmin
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.daily_test_sum_id
    IS 'Unique identifier of a daily test summary record. .';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.calc_test_result_cd
    IS 'Code used to identify reported test result.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.delete_ind
    IS 'Indicates whether the supplemental data is in a deleted state, and that ECMPS client synchronization should delete it from the each client.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.daily_test_supp_data.update_date
    IS 'Date and time in which record was last updated.';
