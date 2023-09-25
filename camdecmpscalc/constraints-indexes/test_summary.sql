ALTER TABLE IF EXISTS camdecmpscalc.test_summary
    ADD CONSTRAINT pk_test_summary PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_test_summary_chk_session_id
    ON camdecmpscalc.test_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_test_summary_test_sum_id
    ON camdecmpscalc.test_summary USING btree
    (test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
