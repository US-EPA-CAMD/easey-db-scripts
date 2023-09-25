ALTER TABLE IF EXISTS camdecmpscalc.sorbent_trap
    ADD CONSTRAINT pk_sorbent_trap PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_sorbent_trap_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_chk_session_id
    ON camdecmpscalc.sorbent_trap USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sorbent_trap_trap_id
    ON camdecmpscalc.sorbent_trap USING btree
    (trap_id COLLATE pg_catalog."default" ASC NULLS LAST);
