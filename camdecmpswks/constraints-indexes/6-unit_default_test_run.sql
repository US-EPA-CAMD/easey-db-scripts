ALTER TABLE IF EXISTS camdecmpswks.unit_default_test_run
    ADD CONSTRAINT pk_unit_default_test_run PRIMARY KEY (unit_default_test_run_id),
    ADD CONSTRAINT fk_unit_default_test_run_unit_default_test FOREIGN KEY (unit_default_test_sum_id)
        REFERENCES camdecmpswks.unit_default_test (unit_default_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_unit_default_test_run_unit_default_test_sum_id
    ON camdecmpswks.unit_default_test_run USING btree
    (unit_default_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
