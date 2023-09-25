ALTER TABLE IF EXISTS camdecmpscalc.weekly_system_integrity
    ADD CONSTRAINT pk_weekly_system_integrity PRIMARY KEY (pk),
   	ADD CONSTRAINT fk_weekly_system_integrity_check_session FOREIGN KEY (chk_session_id)
        REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
        ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_chk_session_id
    ON camdecmpscalc.weekly_system_integrity USING btree
    (chk_session_id COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_weekly_system_integrity_weekly_sys_integrity_id
    ON camdecmpscalc.weekly_system_integrity USING btree
    (weekly_sys_integrity_id COLLATE pg_catalog."default" ASC NULLS LAST);
