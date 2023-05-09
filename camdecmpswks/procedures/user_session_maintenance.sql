-- PROCEDURE: camdecmpswks.user_session_maintenance()

DROP PROCEDURE IF EXISTS camdecmpswks.user_session_maintenance();

CREATE OR REPLACE PROCEDURE camdecmpswks.user_session_maintenance(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmpswks.user_check_out
	WHERE last_activity + interval '20 mins' < current_timestamp;
	
	DELETE FROM camdecmpswks.user_session
	WHERE last_activity + interval '20 mins' < current_timestamp
	AND token_expiration + interval '5 mins' < current_timestamp;
END
$BODY$;
