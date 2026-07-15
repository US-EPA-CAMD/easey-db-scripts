CREATE TABLE IF NOT EXISTS camdeasey.submission_stage_log
(
    sub_stage_log_id numeric(38,0) NOT NULL,
    submission_id numeric NOT NULL,
    sub_stage_cd varchar(7) NOT NULL,
    sub_detail_cd varchar(7),
    stage_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    chatter varchar(4000),
    PRIMARY KEY (sub_stage_log_id)
);
COMMENT ON TABLE camdeasey.submission_stage_log
    IS 'Logs the changes in processing state for submission synchronization.';
COMMENT ON COLUMN camdeasey.submission_stage_log.sub_stage_log_id
    IS ' Unique identifier of a submission stage log record.';
COMMENT ON COLUMN camdeasey.submission_stage_log.submission_id
    IS ' Unique identifier of a submission.';
COMMENT ON COLUMN camdeasey.submission_stage_log.sub_stage_cd
    IS ' Code used to identify the submission stage.';
COMMENT ON COLUMN camdeasey.submission_stage_log.sub_detail_cd
    IS ' Code used to identify the submission detail.';
COMMENT ON COLUMN camdeasey.submission_stage_log.stage_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.submission_stage_log.chatter
    IS 'Client Tool log data';