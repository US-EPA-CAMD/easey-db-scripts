-- FUNCTION: camdecmpswks.update_ecmps_status_for_em_evaluation(character varying, integer, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_ecmps_status_for_em_evaluation(character varying, integer, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_em_evaluation(
	vmon_plan_id character varying,
	vperiod_id integer,
	vchk_session_id character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
declare 
    vSubmittable    char(1);
	V_MON_PLAN_ID   character varying;
	V_RPT_PERIOD_ID int;
	vYear  			int;
	vQuarter		int;
	EM_CSR 			CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;
begin
    vSubmittable :='N';
    error_msg := '';
    result := 'T';

	select  coalesce ( max( 'Y' ), 'N' ) as Submittable
      into  vSubmittable
      from  camdecmpswks.EM_SUBMISSION_ACCESS
     where  mon_plan_id = vmon_plan_id
       and  SUBMISSION_AVAILABILITY_CD IN ('GRANTED', 'REQUIRE')
	   and  RPT_PERIOD_ID = vperiod_id;
	   
 	-- delete old evaluation data from check logs	  
	DELETE FROM camdecmpswks.CHECK_SESSION 
            WHERE PROCESS_CD = 'HOURLY' 
			 AND  MON_PLAN_ID = vmon_plan_id 
			 AND  RPT_PERIOD_ID = vperiod_id 
			 AND  CHK_SESSION_ID <> vchk_session_id;
            
    UPDATE camdecmpswks.EMISSION_EVALUATION
            SET NEEDS_EVAL_FLG    = 'N',
                CHK_SESSION_ID    = vchk_session_id    
            WHERE MON_PLAN_ID = vmon_plan_id 
			AND   RPT_PERIOD_ID = vperiod_id;
	
	-- Recreate the View Emission grid data
	SELECT calendar_year, quarter 
	  INTO vYear, vQuarter
	 FROM camdecmpsmd.reporting_period
	WHERE rpt_period_id = vperiod_id;
	
	CALL camdecmpswks.refresh_emissions_views(vmon_plan_id,vYear, vQuarter);	

	-- Update Monitoring Plan Needs Evaluation, if needed
      UPDATE  camdecmpswks.MONITOR_PLAN
           SET NEEDS_EVAL_FLG = 'Y',
               CHK_SESSION_ID = null
        WHERE MON_PLAN_ID = vmon_plan_id
          AND  EXISTS
              ( SELECT  1
                   FROM  camdecmpswks.CHECK_LOG chl
                    JOIN camdecmpsmd.CHECK_CATALOG_RESULT ccr ON ccr.CHECK_CATALOG_RESULT_ID = chl.CHECK_CATALOG_RESULT_ID
                    JOIN camdecmpsmd.CHECK_CATALOG chk ON chk.CHECK_CATALOG_ID = ccr.CHECK_CATALOG_ID
                     WHERE  chl.CHK_SESSION_ID = vchk_session_id
                       AND  chk.CHECK_TYPE_CD = 'HOURGEN'
                       AND  chk.CHECK_NUMBER = 8
                       AND  ccr.CHECK_RESULT = 'C'
                );	
 
   if vSubmittable = 'Y' then  
     create temp table tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);
	    INSERT INTO tmpEmissionsStatus 
		 SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID 
           FROM camdecmpswks.EMISSION_EVALUATION E,
                camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
        		camdecmpswks.MONITOR_PLAN_LOCATION M, 
        		camdecmpsmd.REPORTING_PERIOD R,
        (SELECT MON_LOC_ID, EE.MON_PLAN_ID, EE.RPT_PERIOD_ID,CALENDAR_YEAR, QUARTER 
            FROM camdecmpswks.EMISSION_EVALUATION EE
                INNER JOIN camdecmpsmd.REPORTING_PERIOD RP ON EE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID
                INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION MPL ON EE.MON_PLAN_ID = MPL.MON_PLAN_ID) T
            WHERE E.MON_PLAN_ID = M.MON_PLAN_ID 
			  AND E.RPT_PERIOD_ID = R.RPT_PERIOD_ID 
			  AND E.MON_PLAN_ID = ESA.MON_PLAN_ID 
			  AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID 
			  AND ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE') 
			  AND M.MON_LOC_ID = T.MON_LOC_ID 
			  AND (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
			        (R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER > T.QUARTER))
			  AND T.MON_PLAN_ID = vmon_plan_id
			  AND T.RPT_PERIOD_ID = vperiod_id;

   -- camdecmpswks.emission_evaluation has column=SUBMISSION_AVAILABILITY_CD
           OPEN EM_CSR;
			 LOOP
				FETCH Next from EM_CSR INTO V_MON_PLAN_ID, V_RPT_PERIOD_ID;
  				  Exit when not found;
					  select * into result, error_msg 
				       from camdecmpswks.delete_calculated_em_data_from_workspace(V_MON_PLAN_ID, V_RPT_PERIOD_ID);	
					 -- Deleting Calculated data failed, bail (PJR)
					 IF result = 'F' then
					    return;
				      end if;	
					 RETURN NEXT;
				 end loop;
				CLOSE EM_CSR;	
             
     end if; --vSubmittable if
  return;
  
exception when others then
    get stacked diagnostics error_msg:= message_text;
    result = 'F';
     error_msg :='From update_ecmps_status_for_em_evaluation' ||' '|| error_msg;
	 
   return;
END;
$BODY$;

