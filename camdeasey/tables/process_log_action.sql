CREATE TABLE IF NOT EXISTS camdeasey.process_log_action
(
    process_log_action_id numeric(38,0) NOT NULL DEFAULT "CAMDEASEY"."PROCESS_LOG_ACTION_SQ"."NEXTVAL",
    process_log_id numeric(38,0) NOT NULL,
    action_name varchar(30) NOT NULL,
    information varchar(4000),
    begin_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    PRIMARY KEY (process_log_action_id)
);
COMMENT ON TABLE camdeasey.process_log_action
    IS 'Logs the name and begin and end time for a action in a process.';
COMMENT ON COLUMN camdeasey.process_log_action.process_log_action_id
    IS 'Primary Key for a PROCESS_LOG_ACTION row.';
COMMENT ON COLUMN camdeasey.process_log_action.process_log_id
    IS 'Primary Key for a PROCESS_LOG row.';
COMMENT ON COLUMN camdeasey.process_log_action.action_name
    IS 'The name of the action associated with the log.';
COMMENT ON COLUMN camdeasey.process_log_action.information
    IS 'Information associated with the call to the action including the input parameters.';
COMMENT ON COLUMN camdeasey.process_log_action.begin_time
    IS 'The date and time that the action started and the log was created.';
COMMENT ON COLUMN camdeasey.process_log_action.end_time
    IS 'The date and time that the action ended.';