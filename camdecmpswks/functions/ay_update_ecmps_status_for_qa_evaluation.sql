-- FUNCTION: camdecmpswks.ay_update_ecmps_status_for_qa_evaluation(character varying, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.ay_update_ecmps_status_for_qa_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.ay_update_ecmps_status_for_qa_evaluation(
	vtestsumid character varying,
	vchksessionid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
   -- vSubmittable    char(1);
	--vListID         character varying; 
    vCount          int;
	vContinue       char(1);
	--I				int;
	--TEST_CSR        CURSOR FOR SELECT TEST_SUM_ID FROM tmpTestsStatus;
	V_TEST_SUM_ID	character varying;
	vTempID         character varying;
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID  int;
	EM_CSR 			CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;
	
begin    
    error_msg := '';
    result := 'T';	
	create temp table tmpTestsStatus (TEST_SUM_ID character varying PRIMARY KEY);
	
 -- Remove check session for the record that are not the current check session. 
	  DELETE FROM camdecmpswks.CHECK_SESSION 
		WHERE TEST_SUM_ID = vTestSumId
		 AND  CHK_SESSION_ID != vChkSessionId;	
		
		 
      UPDATE camdecmpswks.TEST_SUMMARY
			SET NEEDS_EVAL_FLG	= 'N', 	
			    CHK_SESSION_ID	= vChkSessionId	
			WHERE TEST_SUM_ID = vTestSumId;
 	
		
		UPDATE camdecmpswks.QA_SUPP_DATA
			SET UPDATED_STATUS_FLG	= 'Y'
			WHERE TEST_SUM_ID = vTestSumId AND (
				submission_availability_cd IS NULL OR
				submission_availability_cd = 'GRANTED' OR
				submission_availability_cd = 'REQUIRE');
		
		--common part for QA Test-------
		vContinue:='Y';		
			   --Check no test_sum_id or can't submit
				SELECT count(*) into vCount
					FROM camdecmpswks.QA_SUPP_DATA
					 WHERE TEST_SUM_ID != vTestSumId OR (
						TEST_SUM_ID = vTestSumId AND (
							submission_availability_cd IS NULL OR
							submission_availability_cd = 'GRANTED' OR
							submission_availability_cd = 'REQUIRE' ));

			  if vCount=0 then 
				      vContinue:='N';
                end if;
				   
	 If vContinue='Y' then
		   	-- wipe out calculated test data for related tests		
				   INSERT INTO tmpTestsStatus 
						SELECT TT.TEST_SUM_ID FROM (
							SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T,
							(SELECT TS.MON_SYS_ID, TS.END_DATE, TS.END_HOUR, TS.END_MIN, TS.TEST_SUM_ID
								FROM camdecmpswks.TEST_SUMMARY TS
									INNER JOIN camdecmpswks.MONITOR_SYSTEM MS ON TS.MON_SYS_ID = MS.MON_SYS_ID
								WHERE TEST_TYPE_CD = 'RATA' AND SYS_TYPE_CD = 'FLOW') T2
							WHERE T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'F2LREF' AND
								(T.END_DATE > T2.END_DATE OR 
								(T.END_DATE = T2.END_DATE AND T.END_HOUR > T2.END_HOUR) OR
								(T.END_DATE = T2.END_DATE AND T.END_HOUR = T2.END_HOUR AND T.END_MIN >= T2.END_MIN)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId
							UNION SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T, camdecmpsmd.REPORTING_PERIOD R,
							(SELECT TS.MON_SYS_ID, TS.TEST_SUM_ID,
									extract(year from TS.END_DATE) AS CALENDAR_YEAR,
									FLOOR((extract(month from TS.END_DATE) + 2) / 3) AS QUARTER
								FROM camdecmpswks.TEST_SUMMARY TS
									INNER JOIN camdecmpswks.MONITOR_SYSTEM MS ON TS.MON_SYS_ID = MS.MON_SYS_ID
								WHERE TEST_TYPE_CD IN ('RATA', 'F2LREF') AND SYS_TYPE_CD = 'FLOW') T2
							WHERE T.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
								T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'F2LCHK' AND
								(R.CALENDAR_YEAR > T2.CALENDAR_YEAR OR 
								(R.CALENDAR_YEAR = T2.CALENDAR_YEAR AND R.QUARTER >= T2.QUARTER)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId
							UNION SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T, camdecmpsmd.REPORTING_PERIOD R,
							(SELECT TS.MON_SYS_ID, TS.TEST_SUM_ID,
									extract(year from TS.END_DATE) AS CALENDAR_YEAR,
									FLOOR((extract(month from TS.END_DATE) + 2) / 3) AS QUARTER
								FROM camdecmpswks.TEST_SUMMARY TS
								WHERE TEST_TYPE_CD = 'FF2LBAS') T2
							WHERE T.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
								T.MON_SYS_ID = T2.MON_SYS_ID AND T.TEST_TYPE_CD = 'FF2LTST' AND
								(R.CALENDAR_YEAR > T2.CALENDAR_YEAR OR 
								(R.CALENDAR_YEAR = T2.CALENDAR_YEAR AND R.QUARTER >= T2.QUARTER)) AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId 
							UNION SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T
								INNER JOIN camdecmpswks.FUEL_FLOW_TO_LOAD_BASELINE B ON T.TEST_SUM_ID = B.TEST_SUM_ID,
								(SELECT TS.MON_LOC_ID, TS.TEST_SUM_ID, TS.TEST_NUM
									FROM camdecmpswks.TEST_SUMMARY TS
									WHERE TEST_TYPE_CD IN ('FFACC', 'FFACCTT')) T2
							WHERE T.MON_LOC_ID = T2.MON_LOC_ID AND T.TEST_TYPE_CD = 'FF2LBAS' AND
								B.ACCURACY_TEST_NUMBER = T2.TEST_NUM AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId 
							UNION SELECT DISTINCT T.TEST_SUM_ID
							FROM camdecmpswks.TEST_SUMMARY T
								INNER JOIN camdecmpswks.FUEL_FLOW_TO_LOAD_BASELINE B ON T.TEST_SUM_ID = B.TEST_SUM_ID,
								(SELECT TS.MON_LOC_ID, TS.TEST_SUM_ID, TS.TEST_NUM
									FROM camdecmpswks.TEST_SUMMARY TS
									WHERE TEST_TYPE_CD = 'PEI') T2
							WHERE T.MON_LOC_ID = T2.MON_LOC_ID AND T.TEST_TYPE_CD = 'FF2LBAS' AND
								B.PEI_TEST_NUMBER = T2.TEST_NUM AND
								T.NEEDS_EVAL_FLG = 'N' AND
								T2.TEST_SUM_ID =vTestSumId ) TT
							LEFT OUTER JOIN camdecmpswks.QA_SUPP_DATA QS ON TT.TEST_SUM_ID = QS.TEST_SUM_ID
							WHERE QS.SUBMISSION_AVAILABILITY_CD IS NULL OR
								QS.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE');
	
		    select * into result, error_msg from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace(vListId);	
		     
			  if result = 'F' then   -- 	del sp failed, bail the loop
				 return next;
			  end if;			
		-- if result ='T' then
	----------------------------------------------
	--	update EM evaluation
	 create temp table camdecmpswks.tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);
		   INSERT INTO camdecmpswks.tmpEmissionsStatus 
		     SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
						FROM camdecmpswks.EMISSION_EVALUATION E,
							camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
							camdecmpswks.MONITOR_PLAN_LOCATION M, 
							camdecmpsmd.REPORTING_PERIOD R,
							(SELECT MON_LOC_ID, TEST_SUM_ID,
							CASE WHEN TS.RPT_PERIOD_ID IS NULL THEN extract(year from TS.END_DATE) ELSE RP.CALENDAR_YEAR END AS CALENDAR_YEAR,
							CASE WHEN TS.RPT_PERIOD_ID IS NULL THEN FLOOR((extract(month from TS.END_DATE) + 2) / 3) ELSE RP.QUARTER END AS QUARTER
						FROM camdecmpswks.TEST_SUMMARY TS
							LEFT OUTER JOIN camdecmpsmd.REPORTING_PERIOD RP ON TS.RPT_PERIOD_ID = RP.RPT_PERIOD_ID) T
						WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
							E.NEEDS_EVAL_FLG = 'N' AND
							E.MON_PLAN_ID = ESA.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
							ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
							M.MON_LOC_ID = T.MON_LOC_ID AND
							(R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
							(R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER)) 
							AND	TEST_SUM_ID IN 
							(select distinct test_sum_id from camdecmpswks.tmpTestsStatus);
	
			OPEN EM_CSR;					
				FETCH EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;
                  WHILE (@@fetch_status = 0) loop
				   select * into result, error_msg 
				   from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);	
					IF result = 'F' then
					 return next;
				    end if;
                end loop;
				CLOSE EM_CSR;
				DEALLOCATE EM_CSR;  			
	 
   end if;
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_ecmps_status_for_qa_evaluation ' ||' '|| error_msg;
	
   return next;
END;
$BODY$;

