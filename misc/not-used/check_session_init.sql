-- PROCEDURE: camdecmpswks.check_session_init()

-- DROP PROCEDURE camdecmpswks.check_session_init();

CREATE OR REPLACE PROCEDURE camdecmpswks.check_session_init(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE

	errMsg text;
	errState text;
	errContext text;
	p_V_RESULT text;
	p_V_ERROR_MSG text;
	p_V_CHK_SESSION_ID text;

BEGIN
	p_V_RESULT := 'T';
	p_V_ERROR_MSG := NULL;

	
    
    IF (p_V_RESULT = 'T')
      THEN
        
        
		    p_V_CHK_SESSION_ID := (SELECT md5(random()::text || clock_timestamp()::text)::uuid)::character varying(45);   

		    -- do our insert now
		    INSERT INTO CHECK_SESSION
		    (
			    CHK_SESSION_ID, 
			    PROCESS_CD, 
			    CATEGORY_CD, 
			    MON_PLAN_ID, 
			    RPT_PERIOD_ID, 
			    TEST_SUM_ID, 
			    QA_CERT_EVENT_ID, 
			    TEST_EXTENSION_EXEMPTION_ID, 
			    EVAL_BEGIN_DATE, 
			    EVAL_END_DATE, 
			    SESSION_COMMENT, 
			    USERID, 
			    LAST_UPDATED
		    )
		    VALUES
		    (
			    p_V_CHK_SESSION_ID, 
			    p_V_PROCESS_CD,
			    p_V_CATEGORY_CD, 
			    p_V_MON_PLAN_ID, 
			    p_V_RPT_PERIOD_ID, 
			    p_V_TEST_SUM_ID,
			    p_V_QA_CERT_EVENT_ID, 
			    p_V_TEST_EXTENSION_EXEMPTION_ID, 
			    p_V_EVAL_BEGIN_DATE, 
			    p_V_EVAL_END_DATE, 
			    'Check Session Started',
			    p_V_USERID,
			    NOW()
		    );
        
      END IF;
    
	EXCEPTION
		WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				p_V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				p_V_RESULT := 'F';
				p_V_CHK_SESSION_ID := NULL;

END;
$BODY$;
