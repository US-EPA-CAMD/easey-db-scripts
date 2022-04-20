-- FUNCTION: camdecmpswks.check_session_failed(text, text)

-- DROP FUNCTION camdecmpswks.check_session_failed(text, text);

CREATE OR REPLACE FUNCTION camdecmpswks.check_session_failed(
	v_chk_session_id text,
	v_error_comment text)
    RETURNS TABLE(p_v_result text, p_v_error_msg text) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE

	errMsg text;
	errState text;
	errContext text;

BEGIN

				p_V_RESULT   := 'T';
				p_V_ERROR_MSG  := '';

				UPDATE camdecmpswks.check_session
				SET SEVERITY_CD = 'FATAL',
				SESSION_COMMENT = 'Check Session Failed: ' || COALESCE(V_ERROR_COMMENT, ''),
				SESSION_END_DATE = NOW(),
				UPDATED_STATUS_FLG = 'Y',
				LAST_UPDATED = NOW()
				WHERE CHK_SESSION_ID = V_CHK_SESSION_ID;

				RAISE INFO 'p_V_RESULT,%,p_V_ERROR_MSG,%',p_V_RESULT,p_V_ERROR_MSG;

				return next;

				EXCEPTION
				WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				p_V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				p_V_RESULT := 'F';
				
				return next;
				
END;
$BODY$;