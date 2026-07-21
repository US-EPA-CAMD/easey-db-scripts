CREATE TABLE IF NOT EXISTS camdecmpsaux.import_queue
(
    import_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 999999999999 CACHE 1 ),
    import_set_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id character varying(45) COLLATE pg_catalog."default" NOT NULL,
    file_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    temp_s3_bucket_file_path text COLLATE pg_catalog."default" NOT NULL,
    file_type_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    oris_code numeric(6,0),
    rpt_period_id numeric(38,0),
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

COMMENT ON TABLE camdecmpsaux.import_queue IS 'Stores one record per file in a bulk import. Child of import_set.';

COMMENT ON COLUMN camdecmpsaux.import_queue.import_id IS 'Primary key for the Import Queue table.';

COMMENT ON COLUMN camdecmpsaux.import_queue.import_set_id IS 'Foreign key to the Import Set table.';

COMMENT ON COLUMN camdecmpsaux.import_queue.mon_plan_id IS 'Foreign key to the Monitor Plan the file targets. Used to lock the plan while the import is in progress.';

COMMENT ON COLUMN camdecmpsaux.import_queue.file_name IS 'Name of the imported file.';

COMMENT ON COLUMN camdecmpsaux.import_queue.temp_s3_bucket_file_path IS 'Full path to the staged file in the S3 staging bucket.';

COMMENT ON COLUMN camdecmpsaux.import_queue.file_type_cd IS 'Type of the imported file: MP, QA, or EM.';

COMMENT ON COLUMN camdecmpsaux.import_queue.oris_code IS 'ORIS code of the facility the file targets.';

COMMENT ON COLUMN camdecmpsaux.import_queue.rpt_period_id IS 'Foreign key to the Reporting Period table. Populated for EM files only.';

COMMENT ON COLUMN camdecmpsaux.import_queue.queued_time IS 'Timestamp for when the file was queued.';

COMMENT ON COLUMN camdecmpsaux.import_queue.claimed_time IS 'Timestamp for when the file was claimed for processing.';

COMMENT ON COLUMN camdecmpsaux.import_queue.started_time IS 'Timestamp for when the file started processing.';

COMMENT ON COLUMN camdecmpsaux.import_queue.completed_time IS 'Timestamp for when the file completed processing.';

COMMENT ON COLUMN camdecmpsaux.import_queue.note IS 'Note indicating why processing the file failed.';

COMMENT ON COLUMN camdecmpsaux.import_queue.note_time IS 'Timestamp for when processing the file failed.';

COMMENT ON COLUMN camdecmpsaux.import_queue.status_cd IS
    'Current status of the file (generated), with the same logic as import_set.status_cd.';
