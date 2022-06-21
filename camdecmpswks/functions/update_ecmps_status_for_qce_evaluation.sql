-- FUNCTION: camdecmpswks.update_ecmps_status_for_qce_evaluation(character varying, character varying)

-- DROP FUNCTION camdecmpswks.update_ecmps_status_for_qce_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_qce_evaluation(
	vchksessionid character varying,
	vqceid character varying)
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
		WHERE QA_CERT_EVENT_ID = vQceId
		 AND  CHK_SESSION_ID != vChkSessionId;	
		 
       UPDATE camdecmpswks.QA_CERT_EVENT
			SET NEEDS_EVAL_FLG	= 'N',	CHK_SESSION_ID	= vChkSessionId	
					WHERE QA_CERT_EVENT_ID = vQceId;
	   
	  select  coalesce ( max( 'Y' ), 'N' ) as Submittable
             into  vSubmittable
         from  camdecmpswks.QA_CERT_EVENT
         where   QA_CERT_EVENT_ID = vQceId
          and  ( UPDATED_STATUS_FLG ='Y' or SUBMISSION_AVAILABILITY_CD = 'REQUIRE');			
      
	----------------------------------------------
     /* not sure if need add the part for  VW_QA_SUPP_DATA in original SP
      
	  */
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
