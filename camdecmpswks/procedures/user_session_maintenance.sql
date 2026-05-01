-- PROCEDURE: camdecmpswks.user_session_maintenance()
DROP PROCEDURE IF EXISTS camdecmpswks.user_session_maintenance ();

CREATE OR REPLACE PROCEDURE camdecmpswks.user_session_maintenance ()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    DELETE FROM camdecmpswks.user_check_out uco
    WHERE NOT EXISTS (
            SELECT
                *
            FROM
                CAMDECMPSAUX.evaluation_set es
                JOIN CAMDECMPSAUX.evaluation_queue eq USING (evaluation_set_id)
            WHERE
                mon_plan_id = uco.mon_plan_id
                AND eq.status_cd NOT IN ('COMPLETE', 'ERROR'))
        AND NOT EXISTS (
            SELECT
                *
            FROM
                CAMDECMPSAUX.submission_set
            WHERE
                mon_plan_id = uco.mon_plan_id
                AND status_cd NOT IN ('COMPLETE', 'ERROR'))
        AND last_activity + interval '20 mins' < CURRENT_TIMESTAMP;
    DELETE FROM camdecmpswks.user_session
    WHERE last_activity + interval '20 mins' < CURRENT_TIMESTAMP
        AND token_expiration + interval '5 mins' < CURRENT_TIMESTAMP;
END
$BODY$;

