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
begin
    
    error_msg := '';
    result := 'T';

    /* Remove check session for the MP that are not the current check session. */
    delete 
      from  camdecmpswks.check_session
        where  process_cd = 'MP'
       and  mon_plan_id = vMonPlanId
       and  chk_session_id != vChkSessionId;
   
    /* Indicate that the MP does not need to be evaluated. */
    update  camdecmpswks.monitor_plan 
       set  needs_eval_flg = 'N',
            last_evaluated_date = current_timestamp,
            chk_session_id = vChkSessionId
     where  mon_plan_id = vMonPlanId;
    
    
    /* Deteremine whether the MP is submittable and potentially update emission and QA information if it is. ( May need to remove depending on decisions about QA and EM in the same workspace. ) */
    select  coalesce ( max( 'Y' ), 'N' ) as Submittable
      into  vSubmittable
      from  camdecmpswks.monitor_plan mp
     where  mon_plan_id = vMonPlanId
       and  ( updated_status_flg ='Y' or submission_availability_cd = 'REQUIRE' );
    
    
    if vSubmittable = 'Y' 
    then 
        
        /*
         * 1)   When Emission Evaluations are implemented.         * 
         *      For each EMISSION_EVALUATION row for the MP where
         *      EMISSION_EVALUATION.NEEDS_EVAL_FLG = 'N' and 
         *      EM_SUBMISSION_ACCESS.SUBMISSION_AVAILABILITY_CD = 'REQUIRE' or'GRANTED' where RPT_PERIOD_ID = EMISSION_EVALUATION.RPT_PERIOD_ID
         * 
         *      Convert and call ECMPS Client SP ECMPS.dbo.DEL_CALCULATED_EMISSIONS_DATA.
         *      - Delete CHECK_SESSION row with CHK_SESSION_ID matching EMISSION_EVALUATION.CHK_SESSION_ID.
         *      - Updates NEEDS_EVAL_FLG to 'Y' and CHK_SESSION_ID to null for the EMISSION_EVALUATION row.
         *      - Nulls the calculated values in each emission table.
         *      - Deletes the DM_EMISSIONS for the matching MON_PLAN_ID and RPT_PERIOD_ID, which deletes the child tables.
         * 
         * 2)   When QA Certification Event Evaluations are implementd.
         *      
         *      For each QA_CERT_EVENT with a MON_LOC_ID matching the MON_LOC_ID for the MP's MONITOR_PLAN_LOCATION rows
         *      - Where NEEDS_EVAL_FLG = 'N' and either SUBMISSION_AVAILABILITY_CD = 'REQUIRE' or UPDATED_STATUS_FLG = 'Y'
         *      - Delete the CHECK_SESSION row with CHK_SESSION_ID matching QA_CERT_EVENT.CHK_SESSION_ID.
         *      - Update NEEDS_EVAL_FLG to 'Y', CHK_SESSION_ID to null, and UPDATE_DATE = Now in the QA_CERT_EVENT row.
         * 
         * 3)   When Test Extension and Exemption Evaluations are implementd.
         *      
         *      For each TEST_EXTENSION_EXEMPTION with a MON_LOC_ID matching the MON_LOC_ID for the MP's MONITOR_PLAN_LOCATION rows
         *      - Where NEEDS_EVAL_FLG = 'N' and either SUBMISSION_AVAILABILITY_CD = 'REQUIRE' or UPDATED_STATUS_FLG = 'Y'
         *      - Delete the CHECK_SESSION row with CHK_SESSION_ID matching QA_CERT_EVENT.CHK_SESSION_ID.
         *      - Update NEEDS_EVAL_FLG to 'Y', CHK_SESSION_ID to null, and UPDATE_DATE = Now in the QA_CERT_EVENT row.
         * 
         * 4)   When QA Test Evaluations are implemented.
         * 
         *      For each TEST_SUMMARY row with a MON_LOC_ID matching the MON_LOC_ID for the MP's MONITOR_PLAN_LOCATION rows  and TEST_SUMMARY.NEEDS_EVAL_FLG = 'N' .
         * 
         *      Convert and call ECMPS Client SP ECMPS.dbo.DEL_CALCULATED_QA_DATA.
         *      - Delete CHECK_SESSION row with CHK_SESSION_ID matching TEST_SUMMARY.CHK_SESSION_ID.
         *      - Updates NEEDS_EVAL_FLG to 'Y' and CHK_SESSION_ID to null for the TEST_SUMMARY row.
         *      - Nulls the calculated values in each test table.
         */
  
  /* For QCE and TEE test */
     if result != 'F' then
      --- For QCE ---------------------
      DELETE FROM camdecmpswks.CHECK_SESSION
	     WHERE CHK_SESSION_ID IN 
	     (SELECT CHK_SESSION_ID FROM camdecmpswks.QA_CERT_EVENT qce, camdecmpswks.MONITOR_PLAN_LOCATION MPL
            WHERE NEEDS_EVAL_FLG = 'N' AND
           (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') AND
			QCE.MON_LOC_ID = MPL.MON_LOC_ID AND	MON_PLAN_ID =vMonPlanId);
			
       UPDATE camdecmpswks.QA_CERT_EVENT
					SET NEEDS_EVAL_FLG = 'Y', CHK_SESSION_ID = null, 
						UPDATE_DATE = current_timestamp
					FROM camdecmpswks.QA_CERT_EVENT qce
						INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON qce.MON_LOC_ID = mpl.MON_LOC_ID 
					WHERE qce.NEEDS_EVAL_FLG = 'N' AND
						(qce.SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR
						qce.UPDATED_STATUS_FLG = 'Y') AND
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
					SET NEEDS_EVAL_FLG = 'Y', CHK_SESSION_ID = null, UPDATE_DATE = current_timestamp
					FROM camdecmpswks.TEST_EXTENSION_EXEMPTION tee
						INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl ON tee.MON_LOC_ID = mpl.MON_LOC_ID 
					WHERE tee.NEEDS_EVAL_FLG = 'N' AND
						(tee.SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR
						tee.UPDATED_STATUS_FLG = 'Y') AND
						mpl.MON_PLAN_ID  = vMonPlanId;
						
	      end if;
	  end if;
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
