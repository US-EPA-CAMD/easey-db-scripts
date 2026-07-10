CREATE TABLE IF NOT EXISTS camdecmpsaux.import_set
(
    import_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    user_id character varying(160) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    add_time timestamp without time zone NOT NULL,
    queued_time timestamp without time zone,
    started_time timestamp without time zone,
    completed_time timestamp without time zone,
    note text COLLATE pg_catalog."default",
    note_time timestamp without time zone,
    status_cd text COLLATE pg_catalog."default" GENERATED ALWAYS AS (
        CASE
            WHEN queued_time IS NULL AND started_time IS NULL AND completed_time IS NULL AND note_time IS NULL THEN 'NEW'::text
            WHEN queued_time IS NOT NULL AND started_time IS NULL AND completed_time IS NULL AND note_time IS NULL THEN 'QUEUED'::text
            WHEN queued_time IS NOT NULL AND started_time IS NOT NULL AND completed_time IS NULL AND note_time IS NULL THEN 'WIP'::text
            WHEN queued_time IS NOT NULL AND started_time IS NOT NULL AND completed_time IS NOT NULL AND note_time IS NULL THEN 'COMPLETE'::text
            WHEN queued_time IS NOT NULL AND started_time IS NOT NULL AND completed_time IS NULL AND note_time IS NOT NULL THEN 'ERROR'::text
            ELSE NULL::text
        END
    ) STORED
);

COMMENT ON TABLE camdecmpsaux.import_set IS 'Stores information about a bulk import of MP, QA, and EM files. Parent of import_queue.';

COMMENT ON COLUMN camdecmpsaux.import_set.import_set_id IS 'Primary key for the Import Set table.';

COMMENT ON COLUMN camdecmpsaux.import_set.user_id IS 'User ID of the person who created the import.';

COMMENT ON COLUMN camdecmpsaux.import_set.user_email IS 'Email address of the user who created the import.';

COMMENT ON COLUMN camdecmpsaux.import_set.add_time IS 'Date and time the record was added to the system.';

COMMENT ON COLUMN camdecmpsaux.import_set.queued_time IS 'Timestamp for when the import was queued.';

COMMENT ON COLUMN camdecmpsaux.import_set.started_time IS 'Timestamp for when the import started processing.';

COMMENT ON COLUMN camdecmpsaux.import_set.completed_time IS 'Timestamp for when the import completed.';

COMMENT ON COLUMN camdecmpsaux.import_set.note IS 'Note indicating why the import failed.';

COMMENT ON COLUMN camdecmpsaux.import_set.note_time IS 'Timestamp for when the import failed.';

COMMENT ON COLUMN camdecmpsaux.import_set.status_cd IS
    'Indicates the current status of the import set. Generated column with logic:
    NEW when all timestamps null,
    QUEUED when only QUEUED_TIME set,
    WIP when QUEUED_TIME and STARTED_TIME set,
    COMPLETE when all timestamps except NOTE_TIME set,
    ERROR when NOTE_TIME set with QUEUED_TIME and STARTED_TIME.';
