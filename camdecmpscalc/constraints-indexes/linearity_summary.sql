ALTER TABLE IF EXISTS camdecmpscalc.linearity_summary
    ADD CONSTRAINT pk_linearity_summary PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_linearity_summary_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_linearity_summary_chk_session_id
    ON camdecmpscalc.linearity_summary USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_linearity_summary_lin_sum_id
    ON camdecmpscalc.linearity_summary USING btree
    (lin_sum_id COLLATE pg_catalog."default" ASC NULLS LAST);
