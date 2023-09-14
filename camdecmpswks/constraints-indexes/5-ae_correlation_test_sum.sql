ALTER TABLE IF EXISTS camdecmpswks.ae_correlation_test_sum
    ADD CONSTRAINT pk_ae_correlation_test_sum PRIMARY KEY (ae_corr_test_sum_id),
    ADD CONSTRAINT fk_ae_correlation_test_sum_test_summary FOREIGN KEY (test_sum_id)
        REFERENCES camdecmpswks.test_summary (test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_sum_test_sum_id
    ON camdecmpswks.ae_correlation_test_sum USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
