CREATE TABLE IF NOT EXISTS camdecmps.unit_default_test_run
(
    unit_default_test_run_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    unit_default_test_sum_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    op_level_num numeric(2,0),
    run_num numeric(2,0) NOT NULL,
    begin_date date,
    begin_hour numeric(2,0),
    begin_min numeric(2,0),
    end_date date,
    end_hour numeric(2,0),
    end_min numeric(2,0),
    response_time numeric(3,0),
    ref_value numeric(8,3),
    userid character varying(160) COLLATE pg_catalog."default",
    add_date timestamp without time zone,
    update_date timestamp without time zone,
    run_used_ind numeric(38,0)
);

COMMENT ON TABLE camdecmps.unit_default_test_run
    IS 'Unit default test run data.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.unit_default_test_run_id
    IS 'Unique identifier of a unit default test run record. ';

COMMENT ON COLUMN camdecmps.unit_default_test_run.unit_default_test_sum_id
    IS 'Unique combination of DB_Token and identity key generated by sequence generator.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.op_level_num
    IS 'Identifies the operating level for this run of a unit default test. ';

COMMENT ON COLUMN camdecmps.unit_default_test_run.run_num
    IS 'Run number. ';

COMMENT ON COLUMN camdecmps.unit_default_test_run.begin_date
    IS 'Date in which information became effective or activity started.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.begin_hour
    IS 'Hour in which information became effective or activity started.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.begin_min
    IS 'Minute in which information became effective or activity started.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.end_date
    IS 'Last date in which information was effective or date in which activity ended.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.end_hour
    IS 'Last hour n which information was effective or hour in which activity ended.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.end_min
    IS 'Last minute in which information was effective or minute in which activity ended.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.response_time
    IS 'Response time in seconds according to Method 20 of Appendix A to Part 60. ';

COMMENT ON COLUMN camdecmps.unit_default_test_run.ref_value
    IS 'The reference method value for the run. ';

COMMENT ON COLUMN camdecmps.unit_default_test_run.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.update_date
    IS 'Date and time in which record was last updated.';

COMMENT ON COLUMN camdecmps.unit_default_test_run.run_used_ind
    IS 'Used to indicate that this run is used to calculate highest 3-run NOx emission rate average at any tested load level. ';
