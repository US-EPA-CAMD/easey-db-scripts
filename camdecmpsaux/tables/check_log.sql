CREATE TABLE IF NOT EXISTS camdecmpsaux.check_log
(
    chk_log_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    chk_session_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    begin_date timestamp without time zone NOT NULL,
    rule_check_id numeric(38,0),
    result_message character varying(1000) COLLATE pg_catalog."default",
    chk_log_comment character varying(1000) COLLATE pg_catalog."default",
    check_catalog_result_id numeric(38,0),
    mon_loc_id character varying(45) COLLATE pg_catalog."default",
    source_table character varying(100) COLLATE pg_catalog."default",
    row_id character varying(45) COLLATE pg_catalog."default",
    test_sum_id character varying(45) COLLATE pg_catalog."default",
    op_begin_date date,
    op_begin_hour numeric(2,0),
    op_end_date date,
    op_end_hour numeric(2,0),
    check_date date,
    check_hour numeric(2,0),
    check_result character varying(75) COLLATE pg_catalog."default",
    severity_cd character varying(7) COLLATE pg_catalog."default",
    suppressed_severity_cd character varying(7) COLLATE pg_catalog."default",
    check_cd character varying(30) COLLATE pg_catalog."default",
    error_suppress_id numeric(38,0)
);

COMMENT ON TABLE camdecmpsaux.check_log
    IS 'Log of evaluation check results associated with a check session.';

COMMENT ON COLUMN camdecmpsaux.check_log.chk_log_id
    IS ' Unique identifier of a check log record.';

COMMENT ON COLUMN camdecmpsaux.check_log.chk_session_id
    IS ' Unique identifier of a check session record.';

COMMENT ON COLUMN camdecmpsaux.check_log.begin_date
    IS ' Date on which information became effective or activity started. ';

COMMENT ON COLUMN camdecmpsaux.check_log.rule_check_id
    IS ' Unique identifier of a rule check record.';

COMMENT ON COLUMN camdecmpsaux.check_log.result_message
    IS ' Check result message.';

COMMENT ON COLUMN camdecmpsaux.check_log.chk_log_comment
    IS ' Check log comment.';

COMMENT ON COLUMN camdecmpsaux.check_log.check_catalog_result_id
    IS ' Unique identifier of a check catalog result record.';

COMMENT ON COLUMN camdecmpsaux.check_log.mon_loc_id
    IS ' Unique identifier of a monitoring location record. ';

COMMENT ON COLUMN camdecmpsaux.check_log.source_table
    IS ' The table accessed by the check.';

COMMENT ON COLUMN camdecmpsaux.check_log.row_id
    IS ' Unique identifier of a row in the check log table.';

COMMENT ON COLUMN camdecmpsaux.check_log.test_sum_id
    IS ' Unique identifier of a test summary record. ';

COMMENT ON COLUMN camdecmpsaux.check_log.op_begin_date
    IS ' Operating Hour begin date (EM data only).';

COMMENT ON COLUMN camdecmpsaux.check_log.op_begin_hour
    IS ' Operating Hour begin hour (EM data only).';

COMMENT ON COLUMN camdecmpsaux.check_log.op_end_date
    IS ' Operating Hour end date (EM data only).';

COMMENT ON COLUMN camdecmpsaux.check_log.op_end_hour
    IS ' Operating Hour end hour (EM data only).';

COMMENT ON COLUMN camdecmpsaux.check_log.check_date
    IS ' Date on which the check was run.';

COMMENT ON COLUMN camdecmpsaux.check_log.check_hour
    IS ' Check hour.';

COMMENT ON COLUMN camdecmpsaux.check_log.check_result
    IS 'Check result of the check that generated the check log entry.';

COMMENT ON COLUMN camdecmpsaux.check_log.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsaux.check_log.suppressed_severity_cd
    IS ' Code used to identify the suppressed error severity.';

COMMENT ON COLUMN camdecmpsaux.check_log.check_cd
    IS ' Code used to identify the check code.';

COMMENT ON COLUMN camdecmpsaux.check_log.error_suppress_id
    IS 'Unique identifier of Error Suppression record.';
