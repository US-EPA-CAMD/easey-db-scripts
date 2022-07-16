-- Constraint: fk_check_log_check_session

-- ALTER TABLE camdecmpswks.check_log DROP CONSTRAINT fk_check_log_check_session;

ALTER TABLE camdecmpswks.check_log
    ADD CONSTRAINT fk_check_log_check_session FOREIGN KEY (chk_session_id)
    REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;
