CREATE OR REPLACE FUNCTION camdecmpswks.CheckSessionCompleted(
	IN V_CHK_SESSION_ID	bigint,
	IN V_SEVERITY_CD		varchar(50),
	OUT V_RESULT			char(1),
	OUT V_ERROR_MSG		varchar(1000)
	)

AS $$
DECLARE

	errMsg text;
	errState text;
	errContext text;


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
$$ LANGUAGE plpgsql SECURITY INVOKER;
