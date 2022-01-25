-- ADD FK CONSTRAINT FOR CHECK ENGINE
ALTER TABLE camdecmpswks.check_log
    DROP CONSTRAINT pk_check_session_check_log,
	ADD CONSTRAINT pk_check_session_check_log FOREIGN KEY (chk_session_id)
    REFERENCES camdecmpswks.check_session (chk_session_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;
	

