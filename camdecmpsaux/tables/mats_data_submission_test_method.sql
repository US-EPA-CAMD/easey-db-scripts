CREATE TABLE IF NOT EXISTS camdecmpsaux.mats_data_submission_test_method (
    mats_data_sub_test_method_id bigserial NOT NULL,
    mats_data_sub_id bigint NOT NULL,
    mats_test_meth_cd varchar(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsaux.mats_data_submission_test_method IS 'Stores information about each test method associated with a MATS Data Submission.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_test_method.mats_data_sub_test_method_id IS 'Primary key for MATS Data Submission Test Method table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_test_method.mats_data_sub_id IS 'Foreign key to the MATS Data Submission table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_test_method.mats_test_meth_cd IS 'Foreign key to the MATS Test Method Code table.';

