ALTER TABLE camdecmpsaux.submission_queue RENAME COLUMN submitted_on TO queued_time;

ALTER TABLE camdecmpsaux.submission_queue
    ADD COLUMN IF NOT EXISTS started_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.submission_queue
    ADD COLUMN IF NOT EXISTS completed_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.submission_queue RENAME COLUMN details TO note;

ALTER TABLE camdecmpsaux.submission_queue
    ADD COLUMN IF NOT EXISTS note_time timestamp WITHOUT time zone;