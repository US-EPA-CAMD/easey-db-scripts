CREATE TABLE IF NOT EXISTS camdeasey.submission_log
(
    submission_id numeric NOT NULL,
    file_type_cd varchar(7) NOT NULL,
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    userid varchar(160),
    mon_plan_id varchar(45),
    last_updated timestamp without time zone,
    rpt_period_id numeric,
    fac_id numeric,
    submission_set_id numeric,
    severity_cd varchar(7),
    end_state_stage_cd varchar(7) NOT NULL,
    end_state_stage_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    check_session_begin_date timestamp without time zone,
    check_session_end_date timestamp without time zone,
    check_session_severity_cd varchar(7),
    activity_user_name varchar(60) NOT NULL,
    activity_login varchar(8),
    activity_add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    load_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (submission_id)
);
COMMENT ON TABLE camdeasey.submission_log
    IS 'Maintains general information for each submission.';
COMMENT ON COLUMN camdeasey.submission_log.submission_id
    IS ' Unique identifier of a submission.';
COMMENT ON COLUMN camdeasey.submission_log.file_type_cd
    IS ' Code used to identify the file type.';
COMMENT ON COLUMN camdeasey.submission_log.add_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.submission_log.userid
    IS ' User account or source of data that added or updated record.';
COMMENT ON COLUMN camdeasey.submission_log.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.submission_log.last_updated
    IS ' Date and time in which record was last updated.';
COMMENT ON COLUMN camdeasey.submission_log.rpt_period_id
    IS 'Identity key for REPORTING_PERIOD table';
COMMENT ON COLUMN camdeasey.submission_log.fac_id
    IS 'Identity key of the FACILITY table';
COMMENT ON COLUMN camdeasey.submission_log.submission_set_id
    IS ' Unique identifier of a submission set.';
COMMENT ON COLUMN camdeasey.submission_log.severity_cd
    IS 'Code used to identify the severity of the check result.';
COMMENT ON COLUMN camdeasey.submission_log.end_state_stage_cd
    IS ' Code used to identify the submission end state stage.';
COMMENT ON COLUMN camdeasey.submission_log.end_state_stage_date
    IS ' Date and time in which the end state stage was added.';
COMMENT ON COLUMN camdeasey.submission_log.check_session_begin_date
    IS ' Date and time in which the check session was started.';
COMMENT ON COLUMN camdeasey.submission_log.check_session_end_date
    IS ' Date and time in which the check session was ended.';
COMMENT ON COLUMN camdeasey.submission_log.check_session_severity_cd
    IS ' Code used to identify the severity of the check result.';
COMMENT ON COLUMN camdeasey.submission_log.activity_user_name
    IS ' The activity user name.';
COMMENT ON COLUMN camdeasey.submission_log.activity_login
    IS ' The activity login.';
COMMENT ON COLUMN camdeasey.submission_log.activity_add_date
    IS ' Date and time in which the activity was added.';
COMMENT ON COLUMN camdeasey.submission_log.load_date
    IS ' Date and time in which record was loaded from source.';