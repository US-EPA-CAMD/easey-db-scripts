ALTER TABLE IF EXISTS camdecmpscalc.daily_emission
    ADD CONSTRAINT pk_daily_emission PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_daily_emission_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_daily_emission_chk_session_id
    ON camdecmpscalc.daily_emission USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_daily_emission_daily_emission_id
    ON camdecmpscalc.daily_emission USING btree
    (daily_emission_id COLLATE pg_catalog."default" ASC NULLS LAST);
