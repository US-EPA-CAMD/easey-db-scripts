-- FUNCTION: camdecmpswks.update_ecmps_status_for_mp_evaluation(character varying, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_ecmps_status_for_mp_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_mp_evaluation(
	vmonplanid character varying,
	vchksessionid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
    vSubmittable    char(1);
	v_test_ids      character varying[];
	emission_record RECORD;
begin
    vSubmittable :='N';
    error_msg := '';
    result := 'T';	
    
    ----Remove check session for the MP that are not the current check session. --------
    delete
      from  camdecmpswks.check_session
     where  process_cd = 'MP'
       and  mon_plan_id = vMonPlanId
       and  chk_session_id != vChkSessionId;
    
    ----Indicate that the MP does not need to be evaluated. -------
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
        ------- For QCE  -------
        DELETE FROM camdecmpswks.CHECK_SESSION
	     WHERE CHK_SESSION_ID IN 
	     (SELECT qce.CHK_SESSION_ID 
		    FROM camdecmpswks.QA_CERT_EVENT qce, camdecmpswks.MONITOR_PLAN_LOCATION mpl
            WHERE NEEDS_EVAL_FLG = 'N' 
			  AND (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') 
			  AND qce.MON_LOC_ID = mpl.MON_LOC_ID AND mpl.MON_PLAN_ID =vMonPlanId);
		
        UPDATE camdecmpswks.QA_CERT_EVENT
		 SET NEEDS_EVAL_FLG = 'Y', 
             EVAL_STATUS_CD = 'EVAL',
		 	 CHK_SESSION_ID = null, 
	 	 	 UPDATE_DATE = current_timestamp
		 where NEEDS_EVAL_FLG = 'N' 
		   AND (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') 
		   AND MON_LOC_ID in (select MON_LOC_ID from camdecmpswks.MONITOR_PLAN_LOCATION
		          where MON_PLAN_ID =vMonPlanId);
		   
        ---- For TEE ----------	
		DELETE FROM camdecmpswks.CHECK_SESSION 
		  WHERE CHK_SESSION_ID IN 
		 (SELECT CHK_SESSION_ID 
		  FROM camdecmpswks.TEST_EXTENSION_EXEMPTION tee, camdecmpswks.MONITOR_PLAN_LOCATION mpl
			WHERE NEEDS_EVAL_FLG = 'N' 	AND
			 (SUBMISSION_AVAILABILITY_CD= 'REQUIRE' OR UPDATED_STATUS_FLG= 'Y') AND
				tee.MON_LOC_ID = mpl.MON_LOC_ID AND MON_PLAN_ID= vMonPlanId);
							
        UPDATE camdecmpswks.TEST_EXTENSION_EXEMPTION
		 SET NEEDS_EVAL_FLG = 'Y', 
             EVAL_STATUS_CD = 'EVAL',
		     CHK_SESSION_ID = null, 
			 UPDATE_DATE = current_timestamp
		  where NEEDS_EVAL_FLG = 'N' 
		    AND (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') 
			AND MON_LOC_ID in 
		    (select MON_LOC_ID from camdecmpswks.MONITOR_PLAN_LOCATION where MON_PLAN_ID =vMonPlanId);	   
		   
        --------- wipe out calculated test data -----------
		   SELECT array_agg(distinct TEST_SUM_ID) INTO v_test_ids FROM camdecmpswks.TEST_SUMMARY ts
			  INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl 
			        ON ts.MON_LOC_ID = mpl.MON_LOC_ID 
			      WHERE NEEDS_EVAL_FLG = 'N' 
				    AND MON_PLAN_ID = vMonPlanId;
						  
        -- Call deletion function with array parameter
        IF v_test_ids IS NOT NULL AND array_length(v_test_ids, 1) > 0 THEN
            select * into result, error_msg 
              from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace(v_test_ids);
        END IF;	
						
		if result = 'T' then
			
            -- Update EM evaluation
            FOR emission_record IN (
                SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID 
                  FROM camdecmpswks.EMISSION_EVALUATION E, camdecmpsaux.EM_SUBMISSION_ACCESS ESA
                 WHERE E.NEEDS_EVAL_FLG = 'N' 
                   AND E.MON_PLAN_ID = ESA.MON_PLAN_ID 
                   AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID 
                   AND SUBMISSION_AVAILABILITY_CD IN ('REQUIRE','GRANTED')
                   AND E.MON_PLAN_ID = vMonPlanId
            ) LOOP
                select * into result, error_msg 
                  from camdecmpswks.delete_calculated_em_data_from_workspace(emission_record.MON_PLAN_ID, emission_record.RPT_PERIOD_ID);	
                        
                IF result = 'F' then
                    EXIT;
                END IF;
            END LOOP;
            
		end if;

    end if;  --vSubmittable = 'Y' 
   
    RETURN NEXT; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_ecmps_status_for_mp_evaluation' ||' '|| error_msg;
	
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;

