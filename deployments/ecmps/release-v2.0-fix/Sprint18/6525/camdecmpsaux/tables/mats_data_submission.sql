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
    fac_id numeric(38, 0) NOT NULL,
    mon_plan_id varchar(45) COLLATE pg_catalog."default" NOT NULL,
    mats_status_cd varchar(7) COLLATE pg_catalog."default" NOT NULL DEFAULT 'NEW',
    user_id varchar(45) COLLATE pg_catalog."default" NOT NULL,
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

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.fac_id IS 'Foreign key to the Plant table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mon_plan_id IS 'Foreign key to the Monitor Plan table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.mats_status_cd IS 'Foreign key to the MATS Status Code table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.user_id IS 'User ID of the person who submitted the data.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.add_time IS 'Date and time the record was added to the system.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission.update_time IS 'Date and time the record was last updated in the system.';

