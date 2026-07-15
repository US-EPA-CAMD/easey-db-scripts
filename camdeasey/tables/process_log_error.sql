CREATE TABLE IF NOT EXISTS camdeasey.process_log_error
(
    process_log_error_id numeric(38,0) NOT NULL DEFAULT "CAMDEASEY"."PROCESS_LOG_ERROR_SQ"."NEXTVAL",
    process_log_action_id numeric(38,0) NOT NULL,
    error_number integer,
    error_message varchar(4000) NOT NULL,
    plsql_unit varchar(30),
    plsql_line integer,
    backtrace varchar(4000),
    json clob,
    add_time timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (process_log_error_id)
);
COMMENT ON TABLE camdeasey.process_log_error
    IS 'Logs the name and begin and end time for a action in a process.';
COMMENT ON COLUMN camdeasey.process_log_error.process_log_error_id
    IS 'Primary Key for a PROCESS_LOG_ERROR row.';
COMMENT ON COLUMN camdeasey.process_log_error.process_log_action_id
    IS 'Primary Key for a PROCESS_LOG_ACTION row.';
COMMENT ON COLUMN camdeasey.process_log_error.error_number
    IS 'The error number for an exception.';
COMMENT ON COLUMN camdeasey.process_log_error.error_message
    IS 'The error message for an exception.';
COMMENT ON COLUMN camdeasey.process_log_error.plsql_unit
    IS 'The PL/SQL unit containing that produced the error.';
COMMENT ON COLUMN camdeasey.process_log_error.plsql_line
    IS 'The PL/SQL unit line that produced the error.';
COMMENT ON COLUMN camdeasey.process_log_error.backtrace
    IS 'Contains the JSON involved in the error if it exists.';
COMMENT ON COLUMN camdeasey.process_log_error.add_time
    IS 'The time that the error was logged.';