CREATE TABLE IF NOT EXISTS camdecmpsaux.mats_data_submission_payload_file (
    mats_data_sub_payload_file_id bigserial NOT NULL,
    mats_data_sub_id bigint NOT NULL,
    mats_data_file_type_cd varchar(7) COLLATE pg_catalog."default" NOT NULL,
    file_name text COLLATE pg_catalog."default" NOT NULL,
    temp_s3_bucket_file_path text COLLATE pg_catalog."default" NOT NULL,
    temp_s3_bucket_file_time timestamp without time zone NOT NULL,
    main_s3_bucket_file_path text COLLATE pg_catalog."default",
    main_s3_bucket_file_time timestamp without time zone
);

COMMENT ON TABLE camdecmpsaux.mats_data_submission_payload_file IS 'Stores information about the MATS Data Submission files imported by the user and the metadata XML for the submission.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.mats_data_sub_payload_file_id IS 'Primary key for MATS Data Submission Payload File table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.mats_data_sub_id IS 'Foreign key to the MATS Data Submission table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.mats_data_file_type_cd IS 'Foreign key to the MATS Data File Type Code table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.file_name IS 'The name of the imported file.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.temp_s3_bucket_file_path IS 'The name (path) of the file in the temporary S3 bucket.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.temp_s3_bucket_file_time IS 'The timestamp indicating when the file was uploaded to the temporary S3 bucket.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.main_s3_bucket_file_path IS 'The name (path) of the file in the main S3 bucket.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_payload_file.main_s3_bucket_file_time IS 'The timestamp indicating when the file was uploaded to the main S3 bucket.';

