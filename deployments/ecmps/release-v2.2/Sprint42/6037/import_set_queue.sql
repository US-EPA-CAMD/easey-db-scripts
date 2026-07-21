-- camdecmpsaux.import_queue

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
    'Indicates the current status of the file. Generated column with the same logic as import_set.status_cd.';

-- camdecmpsaux.import_set

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

-- constraints and indexes

ALTER TABLE IF EXISTS camdecmpsaux.import_set
    ADD CONSTRAINT pk_import_set PRIMARY KEY (import_set_id);

CREATE INDEX IF NOT EXISTS idx_import_set_user_id
    ON camdecmpsaux.import_set USING btree
    (user_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_import_set_status_cd
    ON camdecmpsaux.import_set USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);

ALTER TABLE IF EXISTS camdecmpsaux.import_queue
    ADD CONSTRAINT pk_import_queue PRIMARY KEY (import_id),
    ADD CONSTRAINT fk_import_queue_import_set FOREIGN KEY (import_set_id)
        REFERENCES camdecmpsaux.import_set (import_set_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_import_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_import_queue_import_set_id
    ON camdecmpsaux.import_queue USING btree
    (import_set_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_import_queue_mon_plan_id
    ON camdecmpsaux.import_queue USING btree
    (mon_plan_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_import_queue_rpt_period_id
    ON camdecmpsaux.import_queue USING btree
    (rpt_period_id ASC NULLS LAST);

