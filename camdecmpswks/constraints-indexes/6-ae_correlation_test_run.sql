ALTER TABLE IF EXISTS camdecmpswks.ae_correlation_test_run
    ADD CONSTRAINT pk_ae_correlation_test_run PRIMARY KEY (ae_corr_test_run_id),
    ADD CONSTRAINT fk_ae_correlation_test_run_ae_correlation_test_sum FOREIGN KEY (ae_corr_test_sum_id)
        REFERENCES camdecmpswks.ae_correlation_test_sum (ae_corr_test_sum_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_run_ae_corr_test_sum_id
    ON camdecmpswks.ae_correlation_test_run USING btree
    (ae_corr_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
