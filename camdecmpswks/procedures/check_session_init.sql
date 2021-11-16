-- PROCEDURE: camdecmpswks.check_session_init(text, text, text, integer, text, text, text, date, date, text)

-- DROP PROCEDURE camdecmpswks.check_session_init(text, text, text, integer, text, text, text, date, date, text);

CREATE OR REPLACE PROCEDURE camdecmpswks.check_session_init(
	v_process_cd text,
	v_category_cd text,
	v_mon_plan_id text,
	v_rpt_period_id integer,
	v_test_sum_id text,
	v_qa_cert_event_id text,
	v_test_extension_exemption_id text,
	v_eval_begin_date date,
	v_eval_end_date date,
	v_userid text)
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
			    V_CHK_SESSION_ID, 
			    V_PROCESS_CD,
			    V_CATEGORY_CD, 
			    V_MON_PLAN_ID, 
			    V_RPT_PERIOD_ID, 
			    V_TEST_SUM_ID,
			    V_QA_CERT_EVENT_ID, 
			    V_TEST_EXTENSION_EXEMPTION_ID, 
			    V_EVAL_BEGIN_DATE, 
			    V_EVAL_END_DATE, 
			    'Check Session Started',
			    V_USERID,
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
