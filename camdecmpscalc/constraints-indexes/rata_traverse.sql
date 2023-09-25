ALTER TABLE IF EXISTS camdecmpscalc.rata_traverse
    ADD CONSTRAINT pk_rata_traverse PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_rata_traverse_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_rata_traverse_chk_session_id
    ON camdecmpscalc.rata_traverse USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_rata_traverse_rata_traverse_id
    ON camdecmpscalc.rata_traverse USING btree
    (rata_traverse_id COLLATE pg_catalog."default" ASC NULLS LAST);
