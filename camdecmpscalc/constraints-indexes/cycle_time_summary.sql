ALTER TABLE IF EXISTS camdecmpscalc.cycle_time_summary
    ADD CONSTRAINT pk_cycle_time_summary PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_cycle_time_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_cycle_time_summary_chk_session_id
    ON camdecmpscalc.cycle_time_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_cycle_time_summary_cycle_time_sum_id
    ON camdecmpscalc.cycle_time_summary USING btree
    (cycle_time_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
