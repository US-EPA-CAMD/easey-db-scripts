-- FUNCTION: camdecmpswks.delete_calculated_qa_data_from_workspace()

DROP FUNCTION IF EXISTS camdecmpswks.delete_calculated_qa_data_from_workspace();

CREATE OR REPLACE FUNCTION camdecmpswks.delete_calculated_qa_data_from_workspace(
	)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
declare 
  --I     	int;
 -- vTempID	character varying;
  
BEGIN
    error_msg := '';
    result := 'T';
	 
	-- CHECK_SESSION --
	  DELETE FROM camdecmpswks.CHECK_SESSION 
	    	WHERE CHK_SESSION_ID IN	
		    (SELECT CHK_SESSION_ID FROM camdecmpswks.TEST_SUMMARY WHERE 
		        CHK_SESSION_ID IS NOT NULL and
			    TEST_SUM_ID in (select test_sum_id from tmpTestsStatus));
	
     
	 -- Update for 20 tables--
		UPDATE camdecmpswks.TEST_SUMMARY
		SET NEEDS_EVAL_FLG = 'Y',
			EVAL_STATUS_CD = 'EVAL',
			CHK_SESSION_ID = null,
			CALC_GP_IND = NULL,
			CALC_TEST_RESULT_CD = NULL,
			CALC_SPAN_VALUE = NULL
		WHERE TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.LINEARITY_SUMMARY
		SET CALC_MEAN_REF_VALUE = NULL,
			CALC_MEAN_MEASURED_VALUE = NULL,
			CALC_PERCENT_ERROR = NULL,
			CALC_APS_IND = NULL
		WHERE TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.RATA
		SET CALC_RELATIVE_ACCURACY = NULL,
			CALC_OVERALL_BIAS_ADJ_FACTOR = NULL,
			CALC_RATA_FREQUENCY_CD = NULL,
			CALC_NUM_LOAD_LEVEL = NULL
		WHERE TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.RATA_SUMMARY
		SET CALC_MEAN_RATA_REF_VALUE = NULL, 
			CALC_MEAN_CEM_VALUE = NULL,
			CALC_APS_IND = NULL,
			CALC_MEAN_DIFF = NULL,
			CALC_STND_DEV_DIFF = NULL,
			CALC_CONFIDENCE_COEF = NULL,
			CALC_T_VALUE = NULL,
			CALC_RELATIVE_ACCURACY = NULL,
			CALC_BIAS_ADJ_FACTOR = NULL,
			CALC_AVG_GROSS_UNIT_LOAD = NULL,
			CALC_STACK_AREA = NULL,
			CALC_CALC_WAF = NULL
 		FROM camdecmpswks.RATA
		WHERE RATA_SUMMARY.RATA_ID = RATA.RATA_ID 
		  AND RATA.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		
			
		UPDATE camdecmpswks.RATA_RUN
		SET CALC_RATA_REF_VALUE = NULL
 		FROM camdecmpswks.RATA_SUMMARY, camdecmpswks.RATA
		WHERE RATA_RUN.RATA_SUM_ID = RATA_SUMMARY.RATA_SUM_ID 
		  AND RATA_SUMMARY.RATA_ID = RATA.RATA_ID 
		  AND RATA.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		
		UPDATE camdecmpswks.FLOW_RATA_RUN
		SET CALC_DRY_MOLECULAR_WEIGHT = null,
		    CALC_WET_MOLECULAR_WEIGHT = null,
			CALC_AVG_VEL_W_WALL = null,
			CALC_AVG_VEL_WO_WALL = null,
			CALC_CALC_WAF = null
 		FROM camdecmpswks.RATA_RUN, camdecmpswks.RATA_SUMMARY, camdecmpswks.RATA
		WHERE FLOW_RATA_RUN.RATA_RUN_ID = RATA_RUN.RATA_RUN_ID AND
			  RATA_RUN.RATA_SUM_ID = RATA_SUMMARY.RATA_SUM_ID AND
			  RATA_SUMMARY.RATA_ID = RATA.RATA_ID AND
			  RATA.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		
		UPDATE camdecmpswks.RATA_TRAVERSE
		SET CALC_CALC_VEL = NULL
 		FROM camdecmpswks.FLOW_RATA_RUN, camdecmpswks.RATA_RUN, camdecmpswks.RATA_SUMMARY, camdecmpswks.RATA
		WHERE RATA_TRAVERSE.FLOW_RATA_RUN_ID = FLOW_RATA_RUN.FLOW_RATA_RUN_ID AND
			  FLOW_RATA_RUN.RATA_RUN_ID = RATA_RUN.RATA_RUN_ID AND
			  RATA_RUN.RATA_SUM_ID = RATA_SUMMARY.RATA_SUM_ID AND
			  RATA_SUMMARY.RATA_ID = RATA.RATA_ID AND
			  RATA.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.CALIBRATION_INJECTION
		SET CALC_ZERO_APS_IND = null,
			CALC_ZERO_CAL_ERROR = null,
			CALC_UPSCALE_APS_IND = null,
			CALC_UPSCALE_CAL_ERROR = null
		WHERE CALIBRATION_INJECTION.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.CYCLE_TIME_INJECTION
		SET CALC_INJECTION_CYCLE_TIME = null
		FROM camdecmpswks.CYCLE_TIME_SUMMARY
		WHERE CYCLE_TIME_INJECTION.CYCLE_TIME_SUM_ID = CYCLE_TIME_SUMMARY.CYCLE_TIME_SUM_ID
		  AND CYCLE_TIME_SUMMARY.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.CYCLE_TIME_SUMMARY
		SET CALC_TOTAL_TIME = null
		WHERE CYCLE_TIME_SUMMARY.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		
			
		UPDATE camdecmpswks.FLOW_TO_LOAD_REFERENCE
		SET CALC_AVG_GROSS_UNIT_LOAD = null,
			CALC_AVG_REF_METHOD_FLOW = null,
			CALC_REF_FLOW_LOAD_RATIO = null,
			CALC_REF_GHR = null
		WHERE FLOW_TO_LOAD_REFERENCE.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.ON_OFF_CAL
		SET CALC_ONLINE_ZERO_APS_IND = null,
			CALC_ONLINE_ZERO_CAL_ERROR = null,
			CALC_ONLINE_UPSCALE_APS_IND = null,
			CALC_ONLINE_UPSCALE_CAL_ERROR = null,
			CALC_OFFLINE_ZERO_APS_IND = null,
			CALC_OFFLINE_ZERO_CAL_ERROR = null,
			CALC_OFFLINE_UPSCALE_APS_IND = null,
			CALC_OFFLINE_UPSCALE_CAL_ERROR = null
		WHERE ON_OFF_CAL.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.AE_CORRELATION_TEST_SUM
		SET CALC_MEAN_REF_VALUE = NULL,
			CALC_AVG_HRLY_HI_RATE = NULL
		WHERE AE_CORRELATION_TEST_SUM.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.AE_CORRELATION_TEST_RUN
		SET CALC_TOTAL_HI = NULL,
		CALC_HOURLY_HI_RATE = NULL
		FROM camdecmpswks.AE_CORRELATION_TEST_SUM
		WHERE AE_CORRELATION_TEST_RUN.AE_CORR_TEST_SUM_ID = AE_CORRELATION_TEST_SUM.AE_CORR_TEST_SUM_ID AND
			  AE_CORRELATION_TEST_SUM.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.AE_HI_GAS
		SET CALC_GAS_HI = NULL
		FROM camdecmpswks.AE_CORRELATION_TEST_RUN, camdecmpswks.AE_CORRELATION_TEST_SUM
		WHERE AE_HI_GAS.AE_CORR_TEST_RUN_ID = AE_CORRELATION_TEST_RUN.AE_CORR_TEST_RUN_ID AND 
			  AE_CORRELATION_TEST_RUN.AE_CORR_TEST_SUM_ID = AE_CORRELATION_TEST_SUM.AE_CORR_TEST_SUM_ID AND
			  AE_CORRELATION_TEST_SUM.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.AE_HI_OIL
		SET CALC_OIL_HI = NULL,
			CALC_OIL_MASS = NULL
		FROM camdecmpswks.AE_CORRELATION_TEST_RUN, camdecmpswks.AE_CORRELATION_TEST_SUM
		WHERE AE_HI_OIL.AE_CORR_TEST_RUN_ID = AE_CORRELATION_TEST_RUN.AE_CORR_TEST_RUN_ID AND 
			  AE_CORRELATION_TEST_RUN.AE_CORR_TEST_SUM_ID = AE_CORRELATION_TEST_SUM.AE_CORR_TEST_SUM_ID AND
			  AE_CORRELATION_TEST_SUM.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);
		

		UPDATE camdecmpswks.UNIT_DEFAULT_TEST
		SET CALC_NOX_DEFAULT_RATE = NULL
		WHERE UNIT_DEFAULT_TEST.TEST_SUM_ID in (select test_sum_id from tmpTestsStatus);

	 return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F';   
   return next;
END;
$BODY$;
