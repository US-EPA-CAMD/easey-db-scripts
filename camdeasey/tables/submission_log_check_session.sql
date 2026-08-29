CREATE TABLE IF NOT EXISTS camdeasey.submission_log_check_session
(
    submission_id numeric NOT NULL,
    chk_session_id varchar(45) NOT NULL,
    PRIMARY KEY (submission_id, chk_session_id)
);
COMMENT ON TABLE camdeasey.submission_log_check_session
    IS 'Associates submission log records with check session records.';
COMMENT ON COLUMN camdeasey.submission_log_check_session.submission_id
    IS ' Unique identifier of a submission.';
COMMENT ON COLUMN camdeasey.submission_log_check_session.chk_session_id
    IS ' Unique identifier of a check session record.';