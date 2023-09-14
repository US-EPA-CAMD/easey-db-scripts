ALTER TABLE IF EXISTS camdecmpsaux.submission_queue
    ADD CONSTRAINT pk_submission_queue PRIMARY KEY (submission_id),
    ADD CONSTRAINT fk_submission_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_submission_queue_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE,
    ADD CONSTRAINT fk_submission_queue_submission_set FOREIGN KEY (submission_set_id)
        REFERENCES camdecmpsaux.submission_set (submission_set_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_submission_queue_submission_set_id
    ON camdecmps.submission_queue USING btree
    (submission_set_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_process_cd
    ON camdecmps.submission_queue USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_test_sum_id
    ON camdecmps.submission_queue USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_qa_cert_event_id
    ON camdecmps.submission_queue USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_test_extension_exemption_id
    ON camdecmps.submission_queue USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_rpt_period_id
    ON camdecmps.submission_queue USING btree
    (rpt_period_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_mats_bulk_file_id
    ON camdecmps.submission_queue USING btree
    (mats_bulk_file_id ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_severity_cd
    ON camdecmps.submission_queue USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_submission_queue_status_cd
    ON camdecmps.submission_queue USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
