CREATE TABLE IF NOT EXISTS camdecmpsaux.submission_migration
(
    old_submission_id               numeric(38)                     NOT NULL,
    new_submission_id               numeric(38)                     NOT NULL,
    new_submission_set_id           numeric(38)                     NOT NULL,
    process_cd                      character varying(7)            COLLATE pg_catalog."default" NOT NULL,
    mon_plan_id                     character varying(45)           COLLATE pg_catalog."default" NOT NULL,
    rpt_period_id                   numeric(38),
    test_sum_id                     character varying(45)           COLLATE pg_catalog."default",
    qa_cert_event_id                character varying(45)           COLLATE pg_catalog."default",
    test_extension_exemption_id     character varying(45)           COLLATE pg_catalog."default",
    severity_cd                     character varying(7)            COLLATE pg_catalog."default" ,
    status_cd                       character varying(8)            COLLATE pg_catalog."default" DEFAULT 'COMPLETE' NOT NULL,
    queued_time                     timestamp without time zone,
    started_time                    timestamp without time zone,
    completed_time                  timestamp without time zone,
    note                            character varying(4000)         COLLATE pg_catalog."default",
    note_time                       timestamp without time zone,
    old_submission_differentiator   text
);

-- Add comments for the table
COMMENT ON TABLE CAMDECMPSAUX.SUBMISSION_MIGRATION IS 'Contains information for SUBMISSION_ID value conversions between ECMPS 1.0 and 2.0';

-- Add comments for the columns
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.OLD_SUBMISSION_ID IS 'ECMPS 1.0 unique identifier for a submission.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.NEW_SUBMISSION_ID IS 'ECMPS 2.0 designated unique indentifier far an ECMPS 1.0 submission.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.NEW_SUBMISSION_SET_ID IS 'ECMPS 2.0 designated unique indentifier far an ECMPS 1.0 submission set.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.PROCESS_CD IS 'Code used to indicate the file type.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.MON_PLAN_ID IS 'Unique identifier of a monitoring plan record.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.RPT_PERIOD_ID IS 'Identity key for REPORTING_PERIOD table.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.TEST_SUM_ID IS 'Unique identifier of a test summary record.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.QA_CERT_EVENT_ID IS 'Unique identifier of a QA certification event record.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.TEST_EXTENSION_EXEMPTION_ID IS 'Unique identifier of a test extension exemption record.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.SEVERITY_CD IS 'Code used to indicate the severity level from the check evaluation of the submitted data.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.STATUS_CD IS 'Code used to indicate the status of the submission.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.QUEUED_TIME IS 'Date and time that a submission was queued.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.STARTED_TIME IS 'Date and time that a submission was started.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.COMPLETED_TIME IS 'Date and time that a submission was completed.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.NOTE IS 'Information about a submission failure.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.NOTE_TIME IS 'Date and time that a submission failed.';
COMMENT ON COLUMN CAMDECMPSAUX.SUBMISSION_MIGRATION.OLD_SUBMISSION_DIFFERENTIATOR IS 'Used in conjunction with OLD_SUBMISSION_ID to for a unique logical key.';
