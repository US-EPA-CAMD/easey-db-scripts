ALTER TABLE IF EXISTS camdecmpscalc.daily_calibration
    ADD CONSTRAINT pk_daily_calibration PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_daily_calibration_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_daily_calibration_chk_session_id
    ON camdecmpscalc.daily_calibration USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_calibration_cal_inj_id
    ON camdecmpscalc.daily_calibration USING btree
    (cal_inj_id COLLATE pg_catalog."default" ASC NULLS LAST);
