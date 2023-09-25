ALTER TABLE IF EXISTS camdecmpscalc.rata_summary
    ADD CONSTRAINT pk_rata_summary PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_rata_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_rata_summary_chk_session_id
    ON camdecmpscalc.rata_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_summary_rata_sum_id
    ON camdecmpscalc.rata_summary USING btree
    (rata_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
