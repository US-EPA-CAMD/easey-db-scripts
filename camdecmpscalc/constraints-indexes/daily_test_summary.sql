ALTER TABLE IF EXISTS camdecmpscalc.daily_test_summary
    ADD CONSTRAINT pk_daily_test_summary PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_daily_test_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_chk_session_id
    ON camdecmpscalc.daily_test_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_test_summary_daily_test_sum_id
    ON camdecmpscalc.daily_test_summary USING btree
    (daily_test_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
