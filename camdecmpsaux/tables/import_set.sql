CREATE TABLE IF NOT EXISTS camdecmpsaux.import_set
(
    import_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    user_id character varying(160) COLLATE pg_catalog."default" NOT NULL,
    user_email character varying(100) COLLATE pg_catalog."default" NOT NULL,
    queued_time timestamp without time zone NOT NULL,
    claimed_time timestamp without time zone,
    started_time timestamp without time zone,
    completed_time timestamp without time zone,
    note text COLLATE pg_catalog."default",
    note_time timestamp without time zone,
    status_cd text COLLATE pg_catalog."default" GENERATED ALWAYS AS (
        CASE
            WHEN note_time IS NOT NULL THEN 'ERROR'::text
            WHEN completed_time IS NOT NULL THEN 'COMPLETE'::text
            WHEN started_time IS NOT NULL THEN 'WIP'::text
            WHEN claimed_time IS NOT NULL THEN 'CLAIMED'::text
            WHEN queued_time IS NOT NULL THEN 'QUEUED'::text
            ELSE NULL::text
        END
    ) STORED
);

COMMENT ON TABLE camdecmpsaux.import_set IS 'Stores information about a bulk import of MP, QA, and EM files. Parent of import_queue.';

COMMENT ON COLUMN camdecmpsaux.import_set.import_set_id IS 'Primary key for the Import Set table.';

COMMENT ON COLUMN camdecmpsaux.import_set.user_id IS 'User ID of the person who created the import.';

COMMENT ON COLUMN camdecmpsaux.import_set.user_email IS 'Email address of the user who created the import.';

COMMENT ON COLUMN camdecmpsaux.import_set.queued_time IS 'Timestamp for when the import was queued.';

COMMENT ON COLUMN camdecmpsaux.import_set.claimed_time IS 'Timestamp for when the Quartz job claimed the import for processing.';

COMMENT ON COLUMN camdecmpsaux.import_set.started_time IS 'Timestamp for when the import started processing.';

COMMENT ON COLUMN camdecmpsaux.import_set.completed_time IS 'Timestamp for when the import completed.';

COMMENT ON COLUMN camdecmpsaux.import_set.note IS 'Note indicating why the import failed.';

COMMENT ON COLUMN camdecmpsaux.import_set.note_time IS 'Timestamp for when the import failed.';

COMMENT ON COLUMN camdecmpsaux.import_set.status_cd IS
    'Current status of the import set (generated). ERROR when NOTE_TIME set;
    otherwise COMPLETE, WIP, CLAIMED, or QUEUED by the latest timestamp set.';
