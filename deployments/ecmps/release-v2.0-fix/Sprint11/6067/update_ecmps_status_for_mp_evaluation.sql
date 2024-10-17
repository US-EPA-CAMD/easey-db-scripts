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
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID  int;
	EM_CSR 			CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;
begin
    vSubmittable :='N';
    error_msg := '';
    result := 'T';	
    ----Remove check session for the MP that are not the current check session. --------
    delete  from  camdecmpswks.check_session
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
          where mon_plan_id = vMonPlanId
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
		     CHK_SESSION_ID = null, 
			 UPDATE_DATE = current_timestamp
		  where NEEDS_EVAL_FLG = 'N' 
		    AND (SUBMISSION_AVAILABILITY_CD = 'REQUIRE' OR UPDATED_STATUS_FLG = 'Y') 
			AND MON_LOC_ID in 
		    (select MON_LOC_ID from camdecmpswks.MONITOR_PLAN_LOCATION where MON_PLAN_ID =vMonPlanId);	   
		   
    --------- wipe out calculated test data -----------
	  create temp table tmpTestsStatus (TEST_SUM_ID character varying PRIMARY KEY);
	  	INSERT INTO tmpTestsStatus 
		   SELECT distinct TEST_SUM_ID FROM camdecmpswks.TEST_SUMMARY ts
			  INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl 
			        ON ts.MON_LOC_ID = mpl.MON_LOC_ID 
			      WHERE NEEDS_EVAL_FLG = 'N' 
				    AND MON_PLAN_ID = vMonPlanId;
						  
	 select * into result, error_msg 
	      from camdecmpswks.Delete_Calculated_QA_Data_from_Workspace();	
						
		   if result ='F' then
		     return;
		    end if;
			
	 create temp table tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);
		--	update EM evaluation		
		INSERT INTO tmpEmissionsStatus 
			  SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID 
				FROM camdecmpswks.EMISSION_EVALUATION E, camdecmpsaux.EM_SUBMISSION_ACCESS ESA
					WHERE E.NEEDS_EVAL_FLG = 'N' 
					  AND E.MON_PLAN_ID = ESA.MON_PLAN_ID 
					  AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID 
					  AND SUBMISSION_AVAILABILITY_CD IN ('REQUIRE','GRANTED')
					  AND E.MON_PLAN_ID = vMonPlanId;						

		  OPEN EM_CSR;
			 LOOP
				FETCH NEXT FROM EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;
  				  EXIT WHEN NOT FOUND;
					 select * into result, error_msg 
				     from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);	
					IF result = 'F' then
					 return;
				    end if;	
				 RETURN NEXT;
			  END LOOP;
			CLOSE EM_CSR;
			

  end if;  --vSubmittable = 'Y' 
   return;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_ecmps_status_for_mp_evaluation' ||' '|| error_msg;
	
   return;
END;
$BODY$;

