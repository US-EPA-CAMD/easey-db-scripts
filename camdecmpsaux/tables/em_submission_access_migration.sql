CREATE TABLE IF NOT EXISTS camdecmpsaux.em_submission_access_migration
(
    em_sub_access_id                integer         NOT NULL,
    submission_id                   integer         NOT NULL
);

-- Add comments for the table
COMMENT ON TABLE camdecmpsaux.em_submission_access_migration IS 'Contains ECMPS 2.0 submission ids for ECMPS 1.0 Submission Window rows.';

-- Add comments for the columns
COMMENT ON COLUMN camdecmpsaux.em_submission_access_migration.em_sub_access_id IS 'The primary key for the EM_SUBMISSION_ACCESS table.';
COMMENT ON COLUMN camdecmpsaux.em_submission_access_migration.submission_id IS 'ECMPS 2.0 submission id based on the ECMPS 1.0 last submission id for a submission window.';
