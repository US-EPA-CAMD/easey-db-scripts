-- PROCEDURE: camdecmpswks.check_session_failed()

-- DROP PROCEDURE camdecmpswks.check_session_failed();

CREATE OR REPLACE PROCEDURE camdecmpswks.check_session_failed(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

	errMsg text;
	errState text;
	errContext text;
	p_V_RESULT text;
	p_V_ERROR_MSG text;

BEGIN

				p_V_RESULT   := 'T';
				p_V_ERROR_MSG  := '';

				UPDATE CHECK_SESSION
				SET SEVERITY_CD = 'FATAL',
				SESSION_COMMENT = 'Check Session Failed: ' || COALESCE(p_V_ERROR_COMMENT, ''),
				SESSION_END_DATE = NOW(),
				UPDATED_STATUS_FLG = 'Y',
				LAST_UPDATED = NOW()
				WHERE CHK_SESSION_ID = p_V_CHK_SESSION_ID;

				RAISE INFO 'p_V_RESULT,%,p_V_ERROR_MSG,%',p_V_RESULT,p_V_ERROR_MSG;

				EXCEPTION
				WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				p_V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				p_V_RESULT := 'F';
				
END;
$BODY$;
