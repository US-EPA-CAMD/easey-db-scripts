-- FUNCTION: camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying)

DROP FUNCTION IF EXISTS camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_tee_evaluation(
	vteeid character varying,
	vchksessionid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
declare 
    vSubmittable    char(1);
begin    
    error_msg := '';
    result := 'T';
	
 /* Remove check session for the record that are not the current check session. */
	  DELETE FROM camdecmpswks.CHECK_SESSION 
		WHERE TEST_EXTENSION_EXEMPTION_ID = vTEEId
		 AND  CHK_SESSION_ID != vChkSessionId;	
		 
       UPDATE camdecmpswks.TEST_EXTENSION_EXEMPTION
			SET NEEDS_EVAL_FLG	= 'N',	
			    CHK_SESSION_ID = vChkSessionId	
		WHERE TEST_EXTENSION_EXEMPTION_ID = vTEEId;
	 
	  select  coalesce ( max( 'Y' ), 'N' ) as Submittable
             into  vSubmittable
         from  camdecmpswks.TEST_EXTENSION_EXEMPTION
           where   TEST_EXTENSION_EXEMPTION_ID = vTEEId
            and  ( UPDATED_STATUS_FLG ='Y' or SUBMISSION_AVAILABILITY_CD = 'REQUIRE');			
      
	----------------------------------------------
     /*IF vSubmittable = 'Y'
       --update EM evaluation part need to be finished later when it's ready in the system
			BEGIN
				--	update EM evaluation
				INSERT INTO @tmpEmissionsStatus SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
					FROM EMISSION_EVALUATION E,
					EM_SUBMISSION_ACCESS ESA,
					MONITOR_PLAN_LOCATION M, 
					REPORTING_PERIOD R,
					(SELECT MON_LOC_ID, TEST_EXTENSION_EXEMPTION_ID,
							CALENDAR_YEAR, QUARTER 
						FROM TEST_EXTENSION_EXEMPTION TEE
							INNER JOIN REPORTING_PERIOD RP ON TEE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID) T
						WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
							E.NEEDS_EVAL_FLG = 'N' AND
							E.MON_PLAN_ID = ESA.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
							ESA.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
							M.MON_LOC_ID = T.MON_LOC_ID AND
							(R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
							(R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER)) AND
							TEST_EXTENSION_EXEMPTION_ID IN
								(SELECT Ids.ID.value('.','varchar(45)') as ID
								 FROM @XMLIDKEYS.nodes('/IDs/ID') as Ids(ID));

				DECLARE EM_CSR CURSOR local FOR
					SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM @tmpEmissionsStatus;

				OPEN EM_CSR;
				FETCH EM_CSR INTO @V_MON_PLAN_ID, @V_RPT_PERIOD_ID;

				WHILE (@@fetch_status = 0) 
				BEGIN
					EXEC dbo.DEL_CALCULATED_EMISSIONS_DATA @V_MON_PLAN_ID = @V_MON_PLAN_ID, @V_RPT_PERIOD_ID = @V_RPT_PERIOD_ID, @V_RESULT = @V_RESULT OUTPUT, @V_ERROR_MSG = @V_ERROR_MSG OUTPUT;
					IF @V_RESULT = 'F'
						BREAK;
					FETCH EM_CSR INTO @V_MON_PLAN_ID, @V_RPT_PERIOD_ID;
				END

				CLOSE EM_CSR;
				DEALLOCATE EM_CSR;	
	  */
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
