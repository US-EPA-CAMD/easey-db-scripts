ALTER TABLE IF EXISTS camdecmpsaux.evaluation_queue
	  ADD CONSTRAINT pk_evaluation_queue PRIMARY KEY (evaluation_id),
    ADD CONSTRAINT fk_evaluation_queue_evaluation_set FOREIGN KEY (evaluation_set_id)
        REFERENCES camdecmpsaux.evaluation_set (evaluation_set_id) MATCH SIMPLE
        ON DELETE CASCADE,
    ADD CONSTRAINT fk_evaluation_queue_reporting_period FOREIGN KEY (rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE,
    ADD CONSTRAINT fk_evaluation_queue_severity_code FOREIGN KEY (severity_cd)
        REFERENCES camdecmpsmd.severity_code (severity_cd) MATCH SIMPLE;

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_evaluation_set_id
    ON camdecmpsaux.evaluation_queue USING btree
    (evaluation_set_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_process_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (process_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_test_sum_id
    ON camdecmpsaux.evaluation_queue USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_qa_cert_event_id
    ON camdecmpsaux.evaluation_queue USING btree
    (qa_cert_event_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_test_extension_exemption_id
    ON camdecmpsaux.evaluation_queue USING btree
    (test_extension_exemption_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_rpt_period_id
    ON camdecmpsaux.evaluation_queue USING btree
    (rpt_period_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_severity_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (severity_cd COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_evaluation_queue_status_cd
    ON camdecmpsaux.evaluation_queue USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
