-- PROCEDURE: camdecmpswks.user_session_maintenance()

DROP PROCEDURE IF EXISTS camdecmpswks.user_session_maintenance();

CREATE OR REPLACE PROCEDURE camdecmpswks.user_session_maintenance(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM camdecmpswks.user_check_out AS uco
	USING camdecmpswks.user_session AS us
	WHERE uco.checked_out_by = us.userid
	AND us.last_activity + interval '15 mins' < current_timestamp;
	
	DELETE FROM camdecmpswks.user_session
	WHERE last_activity + interval '15 mins' < current_timestamp;
END
$BODY$;
