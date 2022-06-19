-- FUNCTION: camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying)

-- DROP FUNCTION camdecmpswks.update_ecmps_status_for_tee_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_tee_evaluation(
	vchksessionid character varying,
	vteeid character varying)
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
			SET NEEDS_EVAL_FLG	= 'N',	CHK_SESSION_ID	= vChkSessionId	
					WHERE TEST_EXTENSION_EXEMPTION_ID = vTEEId;
	 
	  select  coalesce ( max( 'Y' ), 'N' ) as Submittable
             into  vSubmittable
         from  camdecmpswks.TEST_EXTENSION_EXEMPTION
         where   TEST_EXTENSION_EXEMPTION_ID = vTEEId
          and  ( UPDATED_STATUS_FLG ='Y' or SUBMISSION_AVAILABILITY_CD = 'REQUIRE');			
      
	----------------------------------------------
     /*IF vSubmittable = 'Y'
        update EM evaluation
	
	  */
   return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';
   
   return next;
END;
$BODY$;
