ALTER TABLE IF EXISTS camdecmpscalc.on_off_cal
    ADD CONSTRAINT pk_on_off_cal PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_on_off_cal_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_on_off_cal_chk_session_id
    ON camdecmpscalc.on_off_cal USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_on_off_cal_on_off_cal_id
    ON camdecmpscalc.on_off_cal USING btree
    (on_off_cal_id COLLATE pg_catalog."default" ASC NULLS LAST);
