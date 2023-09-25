ALTER TABLE IF EXISTS camdecmpscalc.daily_fuel
    ADD CONSTRAINT pk_daily_fuel PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_daily_fuel_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_daily_fuel_chk_session_id
    ON camdecmpscalc.daily_fuel USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_fuel_daily_fuel_id
    ON camdecmpscalc.daily_fuel USING btree
    (daily_fuel_id COLLATE pg_catalog."default" ASC NULLS LAST);
