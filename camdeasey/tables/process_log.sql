CREATE TABLE IF NOT EXISTS camdeasey.process_log
(
    process_log_id numeric(38,0) NOT NULL DEFAULT "CAMDEASEY"."PROCESS_LOG_SQ"."NEXTVAL",
    process_name varchar(30) NOT NULL,
    information varchar(4000),
    begin_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    PRIMARY KEY (process_log_id)
);
COMMENT ON TABLE camdeasey.process_log
    IS 'Logs the name and begin and end time for a process.';
COMMENT ON COLUMN camdeasey.process_log.process_log_id
    IS 'Primary Key for a PROCESS_LOG row.';
COMMENT ON COLUMN camdeasey.process_log.process_name
    IS 'The name of the process associated with the log.';
COMMENT ON COLUMN camdeasey.process_log.information
    IS 'Information associated with the call to the process including the input parameters.';
COMMENT ON COLUMN camdeasey.process_log.begin_time
    IS 'The date and time that the process started and the log was created.';
COMMENT ON COLUMN camdeasey.process_log.end_time
    IS 'The date and time that the process ended.';