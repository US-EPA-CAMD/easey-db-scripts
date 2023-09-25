ALTER TABLE IF EXISTS camdecmpscalc.ae_correlation_test_run
    ADD CONSTRAINT pk_ae_correlation_test_run PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_ae_correlation_test_run_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_run_chk_session_id
    ON camdecmpscalc.ae_correlation_test_run USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_ae_correlation_test_run_ae_corr_test_run_id
    ON camdecmpscalc.ae_correlation_test_run USING btree
    (ae_corr_test_run_id COLLATE pg_catalog."default" ASC NULLS LAST);
