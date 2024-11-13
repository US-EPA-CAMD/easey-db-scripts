ALTER TABLE camdecmpsaux.submission_set RENAME COLUMN submitted_on TO queued_time;

ALTER TABLE camdecmpsaux.submission_set
    ADD COLUMN IF NOT EXISTS started_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.submission_set
    ADD COLUMN IF NOT EXISTS completed_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.submission_set RENAME COLUMN details TO note;

ALTER TABLE camdecmpsaux.submission_set
    ADD COLUMN IF NOT EXISTS note_time timestamp WITHOUT time zone;

UPDATE camdecmpsaux.submission_set
    SET completed_time = submission_end_stage_time
    WHERE submission_end_stage_time IS NOT NULL;

ALTER TABLE camdecmpsaux.submission_set
    DROP COLUMN submission_end_stage_time;

