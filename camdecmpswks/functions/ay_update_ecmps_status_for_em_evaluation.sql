-- FUNCTION: camdecmpswks.ay_update_ecmps_status_for_em_evaluation(character varying, integer, character varying)

-- DROP FUNCTION IF EXISTS camdecmpswks.ay_update_ecmps_status_for_em_evaluation(character varying, integer, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.ay_update_ecmps_status_for_em_evaluation(
	vmon_plan_id character varying,
	vperiod_id integer,
	vchk_session_id character varying)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin
    
    error_msg := '';
    result := 'T';
	
	DELETE FROM camdecmpswks.CHECK_SESSION 
            WHERE PROCESS_CD = 'HOURLY' AND
                MON_PLAN_ID = vmon_plan_id AND
                RPT_PERIOD_ID = vperiod_id AND
                CHK_SESSION_ID <> vchk_session_id;
            
    UPDATE camdecmpswks.EMISSION_EVALUATION
            SET NEEDS_EVAL_FLG    = 'N',
                CHK_SESSION_ID    = vchk_session_id    
            WHERE MON_PLAN_ID = vmon_plan_id AND
                RPT_PERIOD_ID = vperiod_id;
				
	
  return next;
  
exception when others then
    get stacked diagnostics error_msg:= message_text;
    result = 'F';
     error_msg :='From update_ecmps_status_for_em_evaluation' ||' '|| error_msg;
	 
   return next;
END;
$BODY$;
