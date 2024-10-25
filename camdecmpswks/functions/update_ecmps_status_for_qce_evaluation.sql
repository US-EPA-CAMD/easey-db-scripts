-- FUNCTION: camdecmpswks.update_ecmps_status_for_qce_evaluation(character varying, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.update_ecmps_status_for_qce_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_qce_evaluation(
	vqceid character varying,
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
	EM_CSR CURSOR FOR SELECT MON_PLAN_ID, RPT_PERIOD_ID
					FROM tmpEmissionsStatus;

begin    
    error_msg := '';
    result := 'T';
	
-- Remove check session for the record that are not the current check session. 
	  DELETE FROM camdecmpswks.CHECK_SESSION 
		WHERE QA_CERT_EVENT_ID = vQceId
		 AND  CHK_SESSION_ID != vChkSessionId;	
		 
       UPDATE camdecmpswks.QA_CERT_EVENT
			SET NEEDS_EVAL_FLG	= 'N',	
			    CHK_SESSION_ID	= vChkSessionId	
			WHERE QA_CERT_EVENT_ID = vQceId;
	   
	  select  coalesce ( max( 'Y' ), 'N' ) as Submittable
             into  vSubmittable
         from  camdecmpswks.QA_CERT_EVENT
          where  QA_CERT_EVENT_ID = vQceId
           and (UPDATED_STATUS_FLG ='Y' or SUBMISSION_AVAILABILITY_CD = 'REQUIRE');			
      
	----------------------------------------------
      --EM evaluation part 
    IF vSubmittable = 'Y' then
    create temp table camdecmpswks.tmpEmissionsStatus(MON_PLAN_ID character varying,RPT_PERIOD_ID int);
		--	update EM evaluation
			INSERT INTO camdecmpswks.tmpEmissionsStatus 
				SELECT DISTINCT E.MON_PLAN_ID, E.RPT_PERIOD_ID
					FROM camdecmps.EMISSION_EVALUATION E,
					camdecmpsaux.EM_SUBMISSION_ACCESS ESA,
					camdecmps.MONITOR_PLAN_LOCATION M, 
					camdecmpsmd.REPORTING_PERIOD R,
					(SELECT MON_LOC_ID, QA_CERT_EVENT_ID,
						(SELECT EXTRACT('year' FROM qa_cert_event_date ) )AS CALENDAR_YEAR,
						FLOOR((extract(month from QA_CERT_EVENT_DATE) + 2) / 3) AS QUARTER
						FROM camdecmps.QA_CERT_EVENT) T
					WHERE E.MON_PLAN_ID = M.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = R.RPT_PERIOD_ID AND
							E.NEEDS_EVAL_FLG = 'N' AND
							E.MON_PLAN_ID = ESA.MON_PLAN_ID AND 
							E.RPT_PERIOD_ID = ESA.RPT_PERIOD_ID AND
							ESA.SUBMISSION_AVAILABILITY_CD IN ('GRANTED','REQUIRE') AND
							M.MON_LOC_ID = T.MON_LOC_ID AND
							(R.CALENDAR_YEAR > T.CALENDAR_YEAR OR 
							(R.CALENDAR_YEAR = T.CALENDAR_YEAR AND R.QUARTER >= T.QUARTER)) AND
							QA_CERT_EVENT_ID =vQceId;					

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
				
	  end if; --vSubmittable if
   return;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
    error_msg :='From update_ecmps_status_for_qce_evaluation' ||' '|| error_msg;
	
   return;
END;
$BODY$;
