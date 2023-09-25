ALTER TABLE IF EXISTS camdecmpscalc.ae_correlation_test_sum
    ADD CONSTRAINT pk_ae_correlation_test_sum PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_ae_correlation_test_sum_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_sum_chk_session_id
    ON camdecmpscalc.ae_correlation_test_sum USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_sum_ae_corr_test_sum_id
    ON camdecmpscalc.ae_correlation_test_sum USING btree
    (ae_corr_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
