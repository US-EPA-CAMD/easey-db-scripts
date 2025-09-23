ALTER TABLE camdecmpsaux.em_submission_access
    ADD COLUMN IF NOT EXISTS submission_id bigint,
    ADD CONSTRAINT fk_em_submission_access_submission_queue FOREIGN KEY (submission_id)
        REFERENCES camdecmpsaux.submission_queue (submission_id) MATCH SIMPLE;

COMMENT ON COLUMN camdecmpsaux.em_submission_access.submission_id
    IS 'Foreign key to the SUBMISSION_ID in the SUBMISSION_QUEUE table';
