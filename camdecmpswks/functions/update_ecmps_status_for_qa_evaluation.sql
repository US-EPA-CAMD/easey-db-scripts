-- FUNCTION: camdecmpswks.update_ecmps_status_for_qa_evaluation(character varying, character varying)

-- DROP FUNCTION camdecmpswks.update_ecmps_status_for_qa_evaluation(character varying, character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.update_ecmps_status_for_qa_evaluation(
	vchksessionid character varying,
	vtestsumid character varying)
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
		WHERE TEST_SUM_ID = vTestSumId
		 AND  CHK_SESSION_ID != vChkSessionId;	
		 
      UPDATE camdecmpswks.TEST_SUMMARY
			SET NEEDS_EVAL_FLG	= 'N', 	CHK_SESSION_ID	= vChkSessionId	
			WHERE TEST_SUM_ID = vTestSumId;

	   UPDATE camdecmpswks.QA_SUPP_DATA
			SET UPDATED_STATUS_FLG	= 'Y'
			 FROM camdecmpswks.QA_SUPP_DATA QA, camdecmpswks.VW_QA_SUPP_DATA VW
			  WHERE QA.QA_SUPP_DATA_ID = VW.QA_SUPP_DATA_ID AND
						QA.TEST_SUM_ID =vTestSumId AND CAN_SUBMIT = 'Y';
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
