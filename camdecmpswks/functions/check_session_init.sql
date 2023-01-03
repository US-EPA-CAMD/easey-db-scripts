-- FUNCTION: camdecmpswks.check_session_init(text, text, text, integer, text, text, text, date, date, text, text)

-- DROP FUNCTION camdecmpswks.check_session_init(text, text, text, integer, text, text, text, date, date, text, text);

CREATE OR REPLACE FUNCTION camdecmpswks.check_session_init(
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
    RETURNS TABLE(chk_session character varying, result text, error_msg character varying) 
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
	result:= 'T';
	
   -- copy script from SQL
    --IF v_process_cd = 'HOURLY' then
    --  EXECUTE	DmEm.UpdateReset @V_MON_PLAN_ID, @V_RPT_PERIOD_ID, @V_USERID, @V_RESULT OUTPUT, @V_ERROR_MSG OUTPUT
   SELECT (md5(random()::text || clock_timestamp()::text)::uuid)::character varying(45)
   into chk_session;
	  -- RAISE NOTICE 'Procedure Parameter: %', V_CHK_SESSION_ID ;  
    IF (result = 'T')  THEN  	  
    -- do our insert now
	 INSERT INTO camdecmpswks.CHECK_SESSION
		   (CHK_SESSION_ID, PROCESS_CD,CATEGORY_CD,MON_PLAN_ID,RPT_PERIOD_ID,TEST_SUM_ID,QA_CERT_EVENT_ID,
			TEST_EXTENSION_EXEMPTION_ID, EVAL_BEGIN_DATE, EVAL_END_DATE, SESSION_COMMENT,USERID,LAST_UPDATED, BATCH_ID)
		VALUES(chk_session,v_process_cd,V_CATEGORY_CD,V_MON_PLAN_ID, V_RPT_PERIOD_ID,V_TEST_SUM_ID,V_QA_CERT_EVENT_ID, 
		  V_TEST_EXTENSION_EXEMPTION_ID,V_EVAL_BEGIN_DATE, V_EVAL_END_DATE,'Check Session Started',V_USERID,
		NOW());
    END IF;
		
	result:= 'T';
	error_msg:='';
RETURN NEXT;    
	EXCEPTION
		WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				error_msg:= 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				result:= 'F';
				chk_session:='';
           				
END;
$BODY$;
