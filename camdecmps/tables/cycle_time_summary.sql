CREATE TABLE IF NOT EXISTS camdecmps.cycle_time_summary
(
    cycle_time_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    total_time numeric(2,0),
    calc_total_time numeric(2,0),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone
);

COMMENT ON TABLE camdecmps.cycle_time_summary
    IS 'Cycle time test summary data.  Record Type 621.';

COMMENT ON COLUMN camdecmps.cycle_time_summary.cycle_time_sum_id
    IS 'Unique identifier of cycle time summary record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.test_sum_id
    IS 'Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.total_time
    IS 'Reported time. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.calc_total_time
    IS 'Reported time. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.userid
    IS 'User account or source of data that added or updated record. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.add_date
    IS 'Date and time in which record was added. ';

COMMENT ON COLUMN camdecmps.cycle_time_summary.update_date
    IS 'Date and time in which record was last updated. ';
