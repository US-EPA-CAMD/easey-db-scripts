CREATE TABLE IF NOT EXISTS camdecmpsaux.mats_data_submission (
    mats_data_sub_id bigserial NOT NULL,
    mon_loc_id varchar(45) COLLATE pg_catalog."default" NOT NULL,
    mats_rpt_type_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    mats_avg_group_cd varchar(7) COLLATE pg_catalog."default",
    test_number varchar(100) COLLATE pg_catalog."default",
    test_date date,
    test_comment text COLLATE pg_catalog."default",
    year smallint,
    quarter smallint,
    original_sub_id bigint,
    queued_time timestamp without time zone,
    started_time timestamp without time zone,
    completed_time timestamp without time zone,
    note timestamp without time zone,
    note_time timestamp without time zone,
    activity_id text,
    fac_id numeric(38, 0) NOT NULL,
    mon_plan_id varchar(45) COLLATE pg_catalog."default" NOT NULL,
    mats_status_cd varchar(8) COLLATE pg_catalog."default" NOT NULL DEFAULT 'NEW',
    user_id varchar(45) COLLATE pg_catalog."default" NOT NULL,
    user_email varchar(100) COLLATE pg_catalog."default" NOT NULL,
    add_time timestamp without time zone NOT NULL,
    update_time timestamp without time zone
);

COMMENT ON TABLE camdecmpsaux.mats_data_submission IS 'Stores information about MATS Data Submissions.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mats_data_sub_id IS 'Primary key for MATS Data Submission table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mon_loc_id IS 'Foreign key to the Monitor Location table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mats_rpt_type_cd IS 'Foreign key to the MATS Report Type Code table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mats_avg_group_cd IS 'Foreign key to the MATS Averaging Group Code table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.test_number IS 'Test number for the involved test.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.test_date IS 'Date that the test occurred.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.test_comment IS 'Comment about the test.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.year IS 'Year of the data in a report.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.quarter IS 'Quarter of the data in a report.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.original_sub_id IS 'Foreign key to the original submission when the current submission is a resubmission.';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.QUEUED_TIME IS 'Timestamp for when the submission was queued';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.STARTED_TIME IS 'Timestamp for when the submission started';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.COMPLETED_TIME IS 'Timestamp for when the submission completed';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.NOTE IS 'Note indicating why the submission failed';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.NOTE_TIME IS 'Timestamp for when the submission failed';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.ACTIVITY_ID IS 'Central Data Exchange (CDX) id for the submission';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.fac_id IS 'Foreign key to the Plant table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mon_plan_id IS 'Foreign key to the Monitor Plan table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mats_status_cd IS 
    'Foreign key to the MATS Status Code table.
    Indicates the current status of the submission. Generated column with logic: 
    NEW when all timestamps null, 
    QUEUED when only QUEUED_TIME set, 
    WIP when QUEUED_TIME and STARTED_TIME set, 
    COMPLETE when all timestamps except NOTE_TIME set, 
    ERROR when NOTE_TIME set with other timestamps';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.user_id IS 'User ID of the person who submitted the data.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.add_time IS 'Date and time the record was added to the system.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.update_time IS 'Date and time the record was last updated in the system.';

COMMENT ON COLUMN camdecmpsaux.MATS_DATA_SUBMISSION.user_email IS 'Email address of the user who submitted the data';


