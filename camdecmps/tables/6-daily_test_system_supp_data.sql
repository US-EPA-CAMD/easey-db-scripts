CREATE TABLE IF NOT EXISTS camdecmps.daily_test_system_supp_data
(
    daily_test_system_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    daily_test_supp_data_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_sys_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_hour_cnt numeric(38,0) NOT NULL,
    last_covered_nonop_datehour timestamp without time zone,
    first_op_after_nonop_datehour timestamp without time zone,
    mon_loc_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    userid character varying(25) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    CONSTRAINT pk_daily_test_system_supp_data PRIMARY KEY (daily_test_system_supp_data_id),
    CONSTRAINT fk_daily_test_system_sup_data_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_system_supp_data_daily_test_supp_data FOREIGN KEY (daily_test_supp_data_id)
        REFERENCES camdecmps.daily_test_supp_data (daily_test_supp_data_id) MATCH SIMPLE
        ON DELETE CASCADE,
    CONSTRAINT fk_daily_test_system_supp_data_monitor_location FOREIGN KEY (mon_loc_id)
        REFERENCES camdecmps.monitor_location (mon_loc_id) MATCH SIMPLE,
    CONSTRAINT fk_daily_test_system_supp_data_monitor_system FOREIGN KEY (mon_sys_id)
        REFERENCES camdecmps.monitor_system (mon_sys_id) MATCH SIMPLE
);

COMMENT ON TABLE camdecmps.daily_test_system_supp_data
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.daily_test_system_supp_data_id
    IS 'Unique identifier.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.mon_sys_id
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.op_hour_cnt
    IS 'Count of hours in the quarter for the component and operating supplemental data type.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.last_covered_nonop_datehour
    IS '.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.mon_loc_id
    IS 'Unique identifier of a monitoring location record.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.rpt_period_id
    IS 'Unique identifier of a report period.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.daily_test_system_supp_data.update_date
    IS 'Date and time in which record was last updated.';
