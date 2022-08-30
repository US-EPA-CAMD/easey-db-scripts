-- FUNCTION: camdecmpswks.check_session_completed(text, text)

-- DROP FUNCTION camdecmpswks.check_session_completed(text, text);

CREATE OR REPLACE FUNCTION camdecmpswks.check_session_completed(
	v_chk_session_id text,
	v_severity_cd text)
    RETURNS TABLE(v_result text, v_error_msg text) 
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
	
	V_RESULT := 'T';
	V_ERROR_MSG := '';
	
		UPDATE camdecmpswks.check_session
			SET severity_cd = v_severity_cd,
				session_comment = 'Check Session Completed',
				session_end_date = NOW(),
				updated_status_flg = 'Y',
				last_updated = NOW()
			WHERE chk_session_id = v_chk_session_id;
			
		RAISE INFO 'V_RESULT,%,V_ERROR_MSG,%',V_RESULT,V_ERROR_MSG;
			
		return next;
		
	EXCEPTION
				WHEN OTHERS THEN
				GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				V_RESULT := 'F';
		
		return next;	
	
END;
$BODY$;

