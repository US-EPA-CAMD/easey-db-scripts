-- PROCEDURE: camdecmpswks.check_session_completed(text, text)

-- DROP PROCEDURE camdecmpswks.check_session_completed(text, text);

CREATE OR REPLACE PROCEDURE camdecmpswks.check_session_completed(
	v_chk_session_id text,
	v_severity_cd text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

	errMsg text;
	errState text;
	errContext text;
	V_RESULT text;
	V_ERROR_MSG text;

BEGIN
	
	V_RESULT = 'T';
	V_ERROR_MSG = NULL;

	

		UPDATE CHECK_SESSION
			SET SEVERITY_CD = V_SEVERITY_CD,
				SESSION_COMMENT = 'Check Session Completed',
				SESSION_END_DATE = NOW(),
				UPDATED_STATUS_FLG = 'Y',
				LAST_UPDATED = NOW()
			WHERE CHK_SESSION_ID = V_CHK_SESSION_ID;
			

		EXCEPTION
				WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				V_RESULT := 'F';
				
	
END;
$BODY$;
