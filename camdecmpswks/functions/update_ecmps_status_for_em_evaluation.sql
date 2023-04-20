
-- DROP FUNCTION camdecmpswks.update_ecmps_status_for_em_evaluation(character varying, character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_em_evaluation(
	chksessionid character varying,
	v_process character varying,
	vperiodid integer)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare 
    calendarYear       int;
    v_quarter          int;
	v_mon_plan			varchar;
	v_V_MON_PLAN_ID     int;
    v_V_RPT_PERIOD_ID   int;
    v_SUBMITTABLE       char(1);
	EM_CSR CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID FROM tmpEmissionsStatus;
	 
begin
    
    error_msg := '';
    result := 'T';
   create temp table tmpEmissionsStatus (MON_PLAN_ID VARCHAR2(45), RPT_PERIOD_ID NUMBER);
	   
    -------  Remove check session for the MP that are not the current check session. --------
    IF v_Process = 'EM Import' OR v_Process = 'EM Retrieve' OR 
       v_Process = 'LME Import' OR 
       v_Process = 'LME Generate' OR v_Process = 'LME Data Entry' OR
       v_Process = 'EM Evaluation' OR v_Process = 'EM Loaded' OR v_Process = 'EM Generation' THEN
    
        v_SUBMITTABLE := 'N';
    end if;  
	
		
	
	IF v_Process = 'EM Loaded' THEN
           SELECT CASE
                WHEN COUNT(*) > 0 THEN 'Y'
                ELSE 'N'
                END INTO v_SUBMITTABLE
            FROM camdecmpswks.EMISSION_EVALUATION
            WHERE MON_PLAN_ID = v_ID_KEY_OR_LIST AND
                  RPT_PERIOD_ID = v_PERIOD_ID AND
                  PENDING_STATUS_CD = 'PENDUP';
    ELSE
            SELECT 'Y'
              INTO v_SUBMITTABLE
            FROM camdecmpsaux.EM_SUBMISSION_ACCESS
            WHERE MON_PLAN_ID = v_ID_KEY_OR_LIST AND
                  RPT_PERIOD_ID = v_PERIOD_ID AND
                  SUBMISSION_AVAILABILITY_CD IN ('GRANTED', 'REQUIRE');
     END IF;
	 
	 IF v_Process = 'EM Evaluation' THEN
            DELETE FROM camdecmpswks.CHECK_SESSION 
            WHERE PROCESS_CD = 'HOURLY' AND
                MON_PLAN_ID = v_ID_KEY_OR_LIST AND
                RPT_PERIOD_ID = v_PERIOD_ID AND
                CHK_SESSION_ID <> v_OTHER_FIELD;
            
            UPDATE camdecmpswks.EMISSION_EVALUATION
            SET NEEDS_EVAL_FLG    = 'N',
                CHK_SESSION_ID    = v_OTHER_FIELD    
            WHERE MON_PLAN_ID = v_ID_KEY_OR_LIST AND
                RPT_PERIOD_ID = v_PERIOD_ID;
	 END IF;
	
	SELECT calendar_year, 
	quarter  INTO calendarYear,v_quarter FROM camdecmpsmd.reporting_period
	where rpt_period_id = vperiodid;
	
	SELECT mon_plan_id
	INTO v_mon_plan
	FROM camdecmpswks.check_session
	where check_session_id = chksessionid;
	
	IF V_PROCESS = 'EM Evaluation' THEN
		call camdecmpswks.refresh_emissions_views(v_mon_plan,calendarYear,v_quarter);
	END IF;
	
	IF V_RESULT = 'F' THEN
			RETURN;
	END IF;
	
	IF SUBMITTABLE = 'Y' THEN
		INSERT INTO tmpEmissionsStatus 
		SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
		FROM camdecmpswks.EMISSION_EVALUATION E,
			camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
			camdecmpswks.MONITOR_PLAN_LOCATION M, 
			camdecmpsmd.REPORTING_PERIOD R,
			(SELECT MON_LOC_ID, EE.MON_PLAN_ID, EE.RPT_PERIOD_ID,
					CALENDAR_YEAR, QUARTER 
				FROM EMISSION_EVALUATION EE
					INNER JOIN REPORTING_PERIOD RP ON EE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
					INNER JOIN MONITOR_PLAN_LOCATION MPL ON EE.MON_PLAN_ID = MPL.MON_PLAN_ID) T
		WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND 
			E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
			E.MON_PLAN_ID = ESA.MON_PLAN_ID AND 
			E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
			ESA.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
			M.MON_LOC_ID = T.MON_LOC_ID AND
			(R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
			(R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER > T.QUARTER)) AND
			T.MON_PLAN_ID = V_ID_KEY_OR_LIST AND
			T.RPT_PERIOD_ID = cast(V_PERIOD_ID as varchar);

	--	FOR v_I, v_J IN
	--		SELECT MON_PLAN_ID, RPT_PERIOD_ID
	--		FROM tmpEmissionsStatus
	--	LOOP
	--		PERFORM DEL_CALCULATED_EMISSIONS_DATA(V_MON_PLAN_ID => v_I, V_RPT_PERIOD_ID => v_J);
			-- Changed OUTPUT parameters to PostgreSQL syntax
	--		IF V_RESULT = 'F' THEN
				-- Breaking out of the loop is done by raising an exception in PostgreSQL
	--			RAISE EXCEPTION 'Deleting Calculated data failed';
	--		END IF;
	-- END LOOP;	
	
		OPEN  EM_CSR;
		FETCH EM_CSR INTO v_V_MON_PLAN_ID, v_V_RPT_PERIOD_ID;
			WHILE (Found) 
				LOOP
					CALL DEL_CALCULATED_EMISSIONS_DATA(p_V_MON_PLAN_ID => v_V_MON_PLAN_ID, p_V_RPT_PERIOD_ID => v_V_RPT_PERIOD_ID, p_V_RESULT => v_V_RESULT, p_V_ERROR_MSG => v_V_ERROR_MSG);
					IF p_V_RESULT = 'F' THEN
						EXIT;
					END IF;
					FETCH EM_CSR INTO v_V_MON_PLAN_ID, v_V_RPT_PERIOD_ID;
				END LOOP;

		CLOSE EM_CSR;
	END IF;
  	
   result := 'T';
   error_msg := '';
  	
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
