ALTER TABLE IF EXISTS camdecmpswks.cycle_time_summary
    ADD CONSTRAINT pk_cycle_time_summary PRIMARY KEY (cycle_time_sum_id),
    ADD CONSTRAINT fk_cycle_time_summary_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_cycle_time_summary_test_sum_id
    ON camdecmpswks.cycle_time_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
