ALTER TABLE camdecmpsaux.evaluation_queue RENAME COLUMN submitted_on TO queued_time;

ALTER TABLE camdecmpsaux.evaluation_queue
    ADD COLUMN IF NOT EXISTS started_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.evaluation_queue
    ADD COLUMN IF NOT EXISTS completed_time timestamp WITHOUT time zone;

ALTER TABLE camdecmpsaux.evaluation_queue
    ADD COLUMN IF NOT EXISTS note character varying(1000) COLLATE pg_catalog."default";

ALTER TABLE camdecmpsaux.evaluation_queue
    ADD COLUMN IF NOT EXISTS note_time timestamp WITHOUT time zone;

