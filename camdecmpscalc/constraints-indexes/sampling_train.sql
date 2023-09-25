ALTER TABLE IF EXISTS camdecmpscalc.sampling_train
    ADD CONSTRAINT pk_sampling_train PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_sampling_train_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_sampling_train_chk_session_id
    ON camdecmpscalc.sampling_train USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_sampling_train_trap_train_id
    ON camdecmpscalc.sampling_train USING btree
    (trap_train_id COLLATE pg_catalog."default" ASC NULLS LAST);
