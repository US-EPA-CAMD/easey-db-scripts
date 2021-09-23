-- PROCEDURE: camdecmpswks.ins_check_session()

-- DROP PROCEDURE camdecmpswks.ins_check_session();

CREATE OR REPLACE PROCEDURE camdecmpswks.ins_check_session(
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
	p_V_EM_EVAL_BEGIN_DATE date;
	p_v_eval_begin_date date;
	p_v_em_eval_end_date date;
	p_v_eval_end_date date;
BEGIN
	p_V_RESULT := 'T';
	p_V_ERROR_MSG := 'Check session entry successfully saved.';

	
		-- get the new CHK_SESSION_ID
		p_V_CHK_SESSION_ID := (SELECT md5(random()::text || clock_timestamp()::text)::uuid)::character varying(45);     --- check session ID returned            

		-- default the Emissions dates to whatever is passed in
		p_V_EM_EVAL_BEGIN_DATE := p_V_EVAL_BEGIN_DATE;
		p_V_EM_EVAL_END_DATE := p_V_EVAL_END_DATE;

		-- if RPT_PERIOD_ID is present, then get the emissions dates ( EVAL_BEGIN/END_DATEs should be NULL
		IF p_V_RPT_PERIOD_ID IS NOT NULL
		THEN
			
			
				SELECT QUARTER_BEGIN_DATE,
					 QUARTER_END_DATE,
					 QUARTER_BEGIN_DATE,
					 QUARTER_END_DATE INTO p_V_EM_EVAL_BEGIN_DATE, p_V_EM_EVAL_END_DATE, p_V_EVAL_BEGIN_DATE, p_V_EVAL_END_DATE
				FROM VW_CLIENT_REPORTING_PERIOD
				WHERE RPT_PERIOD_ID = p_V_RPT_PERIOD_ID;
			
		-- if it is not emissions, then don't set the dates at all in CHECK_SESSION
		
		ELSIF p_V_PROCESS_CD <> 'HOURLY'
		THEN
			
			p_V_EM_EVAL_BEGIN_DATE := NULL;
			p_V_EM_EVAL_END_DATE := NULL;
			
		END IF;		

		-- do our insert now
		INSERT INTO CHECK_SESSION
		   (CHK_SESSION_ID, MON_PLAN_ID, TEST_SUM_ID, 
			QA_CERT_EVENT_ID, TEST_EXTENSION_EXEMPTION_ID, 
			RPT_PERIOD_ID, EVAL_BEGIN_DATE, EVAL_END_DATE, 
		    SESSION_BEGIN_DATE, SESSION_END_DATE, SESSION_COMMENT, 
		    EVAL_SCORE_CD, SEVERITY_CD, CATEGORY_CD, PROCESS_CD, 
		    UPDATED_STATUS_FLG, LAST_UPDATED, USERID )
		VALUES
		   (p_V_CHK_SESSION_ID, p_V_MON_PLAN_ID, p_V_TEST_SUM_ID,
			p_V_QA_CERT_EVENT_ID, p_V_TEE_ID, 
			p_V_RPT_PERIOD_ID, p_V_EM_EVAL_BEGIN_DATE, p_V_EM_EVAL_END_DATE,
			p_V_SESSION_BEGIN_DATE, NULL, p_V_SESSION_COMMENT,
			NULL, NULL, p_V_CATEGORY_CD, p_V_PROCESS_CD,
			NULL, NOW(), p_V_USERID );

	EXCEPTION
		WHEN OTHERS THEN
		GET STACKED DIAGNOSTICS
				errState = RETURNED_SQLSTATE,
				errMsg   = MESSAGE_TEXT,
				errContext = PG_EXCEPTION_CONTEXT;
				p_V_ERROR_MSG := 'SQL State: '|| errState || ';Message ' || errMsg || '; Context '|| errContext;
				p_V_RESULT := 'F';
				p_V_CHK_SESSION_ID := 0;

END;
$BODY$;
