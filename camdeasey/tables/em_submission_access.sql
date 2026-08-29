CREATE TABLE IF NOT EXISTS camdeasey.em_submission_access
(
    em_sub_access_id numeric(38,0) NOT NULL,
    mon_plan_id varchar(45) NOT NULL,
    rpt_period_id numeric(38,0) NOT NULL,
    access_begin_date timestamp without time zone NOT NULL,
    access_end_date timestamp without time zone NOT NULL,
    em_sub_type_cd varchar(7) NOT NULL,
    resub_explanation varchar(4000),
    userid varchar(160),
    add_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_date timestamp without time zone,
    em_status_cd varchar(7),
    data_loaded_flg varchar(1),
    sub_availability_cd varchar(7),
    PRIMARY KEY (em_sub_access_id)
);
COMMENT ON TABLE camdeasey.em_submission_access
    IS 'Maintains the windows of submission opportunity for each monitor plan in a given reporting period.';
COMMENT ON COLUMN camdeasey.em_submission_access.em_sub_access_id
    IS ' Unique identifier of an emissions submission access record.';
COMMENT ON COLUMN camdeasey.em_submission_access.mon_plan_id
    IS ' Unique identifier of a monitoring plan record. ';
COMMENT ON COLUMN camdeasey.em_submission_access.rpt_period_id
    IS ' Unique identifier of a reporting period record. ';
COMMENT ON COLUMN camdeasey.em_submission_access.access_begin_date
    IS ' Date and time in which submission access began.';
COMMENT ON COLUMN camdeasey.em_submission_access.access_end_date
    IS ' Date and time in which submission access ended.';
COMMENT ON COLUMN camdeasey.em_submission_access.em_sub_type_cd
    IS ' Code used to identify the emission submission type code.';
COMMENT ON COLUMN camdeasey.em_submission_access.resub_explanation
    IS ' Explanation of reason for resubmission of emissions data.';
COMMENT ON COLUMN camdeasey.em_submission_access.userid
    IS ' User account or source of data that added or updated record.';
COMMENT ON COLUMN camdeasey.em_submission_access.add_date
    IS ' Date and time in which record was added.';
COMMENT ON COLUMN camdeasey.em_submission_access.update_date
    IS ' Date and time in which record was last updated.';
COMMENT ON COLUMN camdeasey.em_submission_access.em_status_cd
    IS ' Code used to identify the emissions status.';
COMMENT ON COLUMN camdeasey.em_submission_access.data_loaded_flg
    IS ' Flag indicating if the data are loaded.';
COMMENT ON COLUMN camdeasey.em_submission_access.sub_availability_cd
    IS 'Identity key for SUBMISSION_AVAILABILITY_CODE table';