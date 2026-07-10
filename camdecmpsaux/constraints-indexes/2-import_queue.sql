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
