-- FUNCTION: camdecmpswks.update_ecmps_status_for_mp_evaluation(character varying, character varying)

-- DROP FUNCTION camdecmpswks.update_ecmps_status_for_mp_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_mp_evaluation(
	vmonplanid character varying,
	vchksessionid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
declare 
    vSubmittable    char(1);
	vTestSumId      character varying;
	I				int;
	TEST_CSR        CURSOR FOR SELECT TEST_SUM_ID FROM tmpTestsStatus;
	vTempID         character varying;
	vListID         character varying; 
begin
    
    error_msg := '';
    result := 'T';
    create temp table tmpTestsStatus (TEST_SUM_ID character varying PRIMARY KEY);
		   
    -------  Remove check session for the MP that are not the current check session. --------
    delete  from  camdecmpswks.check_session
        where  process_cd = 'MP'
       and  mon_plan_id = vMonPlanId
       and  chk_session_id != vChkSessionId;
    
    -------  Indicate that the MP does not need to be evaluated. -------
    update  camdecmpswks.monitor_plan 
       set  needs_eval_flg = 'N',
            last_evaluated_date = current_timestamp,
            chk_session_id = vChkSessionId
         where  mon_plan_id = vMonPlanId;
   
    
    /*  Deteremine whether the MP is submittable and potentially update emission and QA information if it is. 
	( May need to remove depending on decisions about QA and EM in the same workspace. ) */
    select  coalesce ( max( 'Y' ), 'N' ) as Submittable
      into  vSubmittable
      from  camdecmpswks.monitor_plan mp
     where  mon_plan_id = vMonPlanId
       and  ( updated_status_flg ='Y' or submission_availability_cd = 'REQUIRE' );
     
    
    if vSubmittable = 'Y' then     
     ------- For QCE and TEE test -------
       DELETE FROM camdecmpswks.CHECK_SESSION
	     WHERE CHK_SESSION_ID IN 
	     (SELECT CHK_SESSION_ID FROM camdecmpswks.QA_CERT_EVENT qce, camdecmpswks.MONITOR_PLAN_LOCATION MPL
            WHERE NEEDS_EVAL_FLG = 'N' AND
           (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') AND
			QCE.MON_LOC_ID = MPL.MON_LOC_ID AND	MON_PLAN_ID =vMonPlanId);
		
			
       UPDATE camdecmpswks.QA_CERT_EVENT
		SET NEEDS_EVAL_FLG = 'Y', 
			CHK_SESSION_ID = null, 
			UPDATE_DATE = current_timestamp
	     FROM camdecmpswks.QA_CERT_EVENT qce
			INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON qce.MON_LOC_ID = mpl.MON_LOC_ID 
				WHERE qce.NEEDS_EVAL_FLG = 'N' AND
					(qce.SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR qce.UPDATED_STATUS_FLG = 'Y') AND
					mpl.MON_PLAN_ID =vMonPlanId;
			
	   ---- For TEE ----------
	   DELETE FROM camdecmpswks.CHECK_SESSION 
			WHERE CHK_SESSION_ID IN 
			 (SELECT CHK_SESSION_ID FROM camdecmpswks.TEST_EXTENSION_EXEMPTION tee,camdecmpswks.MONITOR_PLAN_LOCATION MPL
				WHERE NEEDS_EVAL_FLG = 'N' AND (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR
							UPDATED_STATUS_FLG = 'Y') AND
							TEE.MON_LOC_ID = MPL.MON_LOC_ID AND
							MON_PLAN_ID  = vMonPlanId);
             
			  
				UPDATE camdecmpswks.TEST_EXTENSION_EXEMPTION
					SET NEEDS_EVAL_FLG = 'Y', CHK_SESSION_ID = null, 
						UPDATE_DATE = current_timestamp
					FROM camdecmpswks.TEST_EXTENSION_EXEMPTION tee
						INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON tee.MON_LOC_ID = mpl.MON_LOC_ID 
					WHERE tee.NEEDS_EVAL_FLG = 'N' AND
						(tee.SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR	tee.UPDATED_STATUS_FLG = 'Y') AND
						mpl.MON_PLAN_ID  = vMonPlanId;
			       			
	    --------- wipe out calculated test data -----------
		INSERT INTO tmpTestsStatus 
		    SELECT TEST_SUM_ID FROM camdecmpswks.TEST_SUMMARY ts
			      INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON ts.MON_LOC_ID = mpl.MON_LOC_ID 
			      WHERE NEEDS_EVAL_FLG = 'N' AND
				  		MON_PLAN_ID  = vMonPlanId;
		 select * into result, error_msg from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace();	
						
		/* I:=0;
		   OPEN TEST_CSR;
		     FETCH TEST_CSR into vTempID;
			  I:=I+1;		   
			 If I=1 then 
			   vListID:=vTemID;
			 elsif I>0 and vTempID is not null then
			   vListID:=(vListID||',');
			 end if;
			if I=100 then		 
	 select  camdecmpswks.Delete_Calculated_QA_Data_from_Workspace(result, error_msg);	
				I:=0;
				vListID:=null;
			end if;
			if vListID is not null then
			   select  camdecmpswks.Delete_Calculated_QA_Data_from_Workspace(vListId, result, error_msg );	
			 end if;
		  close TEST_CSR;		 */ 
            
        /*  -- update EM evaluation
       		INSERT INTO @tmpEmissionsStatus SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID 
					FROM EMISSION_EVALUATION E, EM_SUBMISSION_ACCESS ESA
					WHERE E.NEEDS_EVAL_FLG = 'N' AND
						E.MON_PLAN_ID = ESA.MON_PLAN_ID AND
						E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
						SUBMISSION_AVAILABILITY_CD IN ('REQUIRE','GRANTED') AND
						E.MON_PLAN_ID = @V_ID_KEY_OR_LIST;

				DECLARE EM_CSR CURSOR local FOR
					SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM @tmpEmissionsStatus;

				OPEN EM_CSR;
				FETCH EM_CSR INTO @V_MON_PLAN_ID, @V_RPT_PERIOD_ID;

				WHILE (@@fetch_status = 0) 
				BEGIN
					EXEC dbo.DEL_CALCULATED_EMISSIONS_DATA @V_MON_PLAN_ID = @V_MON_PLAN_ID, @V_RPT_PERIOD_ID = @V_RPT_PERIOD_ID, @V_RESULT = @V_RESULT OUTPUT, @V_ERROR_MSG = @V_ERROR_MSG OUTPUT;
					IF @V_RESULT = 'F'
						BREAK;	-- delete sp failed, bail
					FETCH EM_CSR INTO @V_MON_PLAN_ID, @V_RPT_PERIOD_ID;
				END

				CLOSE EM_CSR;
				DEALLOCATE EM_CSR;*/
  end if;  --vSubmittable = 'Y' 
  	
   result := 'T';
   error_msg := '';
  	
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
