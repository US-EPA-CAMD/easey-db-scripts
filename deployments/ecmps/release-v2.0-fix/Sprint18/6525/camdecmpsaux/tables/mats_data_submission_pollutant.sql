CREATE TABLE IF NOT EXISTS camdecmpsaux.mats_data_submission_pollutant (
    mats_data_sub_pollutant_id bigserial NOT NULL,
    mats_data_sub_id bigint NOT NULL,
    mats_pollutant_cd varchar(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsaux.mats_data_submission_pollutant IS 'Stores information about each pollutant associated with a MATS Data Submission.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_pollutant.mats_data_sub_pollutant_id IS 'Primary key for MATS Data Submission Pollutant table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_pollutant.mats_data_sub_id IS 'Foreign key to the MATS Data Submission table.';

COMMENT ON COLUMN camdecmpsaux.mats_data_submission_pollutant.mats_pollutant_cd IS 'Foreign key to the MATS Pollutant Code table.';

