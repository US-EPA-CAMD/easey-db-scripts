CREATE TABLE IF NOT EXISTS camdeasey.submission_queue_detail
(
    submission_id numeric NOT NULL,
    activity_id varchar(45) NOT NULL,
    file_type_cd varchar(7) NOT NULL,
    submission_set varchar(4000),
    queue_status_cd varchar(10) NOT NULL,
    score numeric,
    add_date timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    unit_stack_list varchar(2000),
    submission_set_id numeric NOT NULL,
    PRIMARY KEY (submission_id)
);
COMMENT ON TABLE camdeasey.submission_queue_detail
    IS 'Manages the state of individual submissions within the job queue.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.submission_id
    IS ' Unique identifier of a submission.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.activity_id
    IS ' Unique identifier of activity.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.file_type_cd
    IS ' Code used to identify the file type.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.submission_set
    IS ' Used to identify the submissions included in the set.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.queue_status_cd
    IS ' Code used to identify the queue status.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.score
    IS ' Score associated with submission.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.add_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.update_date
    IS ' Date and time in which record was last updated.';
COMMENT ON COLUMN camdeasey.submission_queue_detail.unit_stack_list
    IS 'Lists the unit/stacks/pipes associated with a submission set';
COMMENT ON COLUMN camdeasey.submission_queue_detail.submission_set_id
    IS 'Unique identifier of a submission set.';