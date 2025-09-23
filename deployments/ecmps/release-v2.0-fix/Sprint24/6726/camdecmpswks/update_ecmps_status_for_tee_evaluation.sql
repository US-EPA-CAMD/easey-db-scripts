-- FUNCTION: camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_tee_evaluation(
	vteeid character varying,
	vchksessionid character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
    vSubmittable    char(1);
	emission_record RECORD;
begin    
    error_msg := '';
    result := 'T';
	
    -- Remove check session for the record that are not the current check session. 
	DELETE FROM camdecmpswks.CHECK_SESSION 
	 WHERE TEST_EXTENSION_EXEMPTION_ID = vteeid
	   AND CHK_SESSION_ID != vchksessionid;	
		 
    UPDATE camdecmpswks.TEST_EXTENSION_EXEMPTION
	   SET NEEDS_EVAL_FLG	= 'N',	
		   CHK_SESSION_ID = vchksessionid	
	 WHERE TEST_EXTENSION_EXEMPTION_ID = vteeid;
	 
	select  coalesce ( max( 'Y' ), 'N' ) as Submittable
      into  vSubmittable
      from  camdecmpswks.TEST_EXTENSION_EXEMPTION
     where   TEST_EXTENSION_EXEMPTION_ID = vteeid
       and  ( UPDATED_STATUS_FLG ='Y' or SUBMISSION_AVAILABILITY_CD = 'REQUIRE');			
      
	----------------------------------------------
    if vSubmittable = 'Y' then

		-- Update EM evaluation
		FOR emission_record IN (
			SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
					FROM camdecmpswks.EMISSION_EVALUATION E,
					camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
					camdecmpswks.MONITOR_PLAN_LOCATION M, 
					camdecmpsmd.REPORTING_PERIOD R,
					(SELECT MON_LOC_ID, TEST_EXTENSION_EXEMPTION_ID,CALENDAR_YEAR, QUARTER 
						FROM camdecmpswks.TEST_EXTENSION_EXEMPTION TEE
						INNER JOIN camdecmpsmd.REPORTING_PERIOD RP ON TEE.RPT_PERIOD_ID = RP.RPT_PERIOD_ID) T
				WHERE E.MON_PLAN_ID = M.MON_PLAN_ID 
				  AND E.RPT_PERIOD_ID = R.RPT_PERIOD_ID 
				  AND E.NEEDS_EVAL_FLG = 'N' 
				  AND E.MON_PLAN_ID = ESA.MON_PLAN_ID 
				  AND E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID 
				  AND ESA.SUB_AVAILABILITY_CD IN ('GRANTED','REQUIRE') 
				  AND M.MON_LOC_ID = T.MON_LOC_ID 
				  AND (R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
							(R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER))
				  AND TEST_EXTENSION_EXEMPTION_ID =vteeid
		) LOOP
		    select * into result, error_msg 
		      from camdecmpswks.delete_calculated_em_data_from_workspace(emission_record.MON_PLAN_ID, emission_record.RPT_PERIOD_ID);	
			
            if result = 'F' then
                EXIT;
			end if;
		END LOOP;	
	end if; --vSubmittable
    
    return next; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_ecmps_status_for_tee_evaluation' ||' '|| error_msg;
	
    return next; -- Add row to return table.
END;
$BODY$;
