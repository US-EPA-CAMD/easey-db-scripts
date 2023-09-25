ALTER TABLE IF EXISTS camdecmpscalc.rata
    ADD CONSTRAINT pk_rata PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_rata_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_rata_chk_session_id
    ON camdecmpscalc.rata USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_rata_id
    ON camdecmpscalc.rata USING btree
    (rata_id COLLATE pg_catalog."default" ASC NULLS LAST);
