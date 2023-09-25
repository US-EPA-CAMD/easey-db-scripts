ALTER TABLE IF EXISTS camdecmpscalc.calibration_injection
    ADD CONSTRAINT pk_calibration_injection PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_calibration_injection_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_calibration_injection_chk_session_id
    ON camdecmpscalc.calibration_injection USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_calibration_injection_cal_inj_id
    ON camdecmpscalc.calibration_injection USING btree
    (cal_inj_id COLLATE pg_catalog."default" ASC NULLS LAST);
