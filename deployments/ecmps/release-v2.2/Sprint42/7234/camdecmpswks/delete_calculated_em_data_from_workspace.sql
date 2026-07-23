-- FUNCTION: camdecmpswks.delete_calculated_em_data_from_workspace(character varying, numeric)

-- DROP FUNCTION IF EXISTS camdecmpswks.delete_calculated_em_data_from_workspace(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.delete_calculated_em_data_from_workspace(
	vmonplan_id character varying,
	vrptperiod_id numeric)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 

	vMON_LOC_ID_LIST VARCHAR ARRAY;
	vEVALUATION_OCCURRED BOOLEAN;
    
BEGIN
    error_msg := '';
    result := 'T';	 
	
	vMON_LOC_ID_LIST := array(select MON_LOC_ID
		FROM camdecmpswks.MONITOR_PLAN_LOCATION 
		 where MON_PLAN_ID = vmonplan_id);

	-- Only clear calculated data when an EM evaluation occurred after the latest successful EM submission.
	SELECT EXISTS (
		SELECT 1
		FROM camdecmpsaux.EVALUATION_SET evs
		JOIN camdecmpsaux.EVALUATION_QUEUE evq
		  ON evq.EVALUATION_SET_ID = evs.EVALUATION_SET_ID
		WHERE evs.MON_PLAN_ID = vmonplan_id
		  AND evq.PROCESS_CD = 'EM'
		  AND evq.RPT_PERIOD_ID = vrptperiod_id
		  AND evq.STATUS_CD = 'COMPLETE'
		  AND evq.COMPLETED_TIME IS NOT NULL
		  AND evq.COMPLETED_TIME > COALESCE((
			SELECT MAX(sbq.COMPLETED_TIME)
			FROM camdecmpsaux.SUBMISSION_SET sbs
			JOIN camdecmpsaux.SUBMISSION_QUEUE sbq
			  ON sbq.SUBMISSION_SET_ID = sbs.SUBMISSION_SET_ID
			WHERE sbs.MON_PLAN_ID = vmonplan_id
			  AND sbq.PROCESS_CD = 'EM'
			  AND sbq.RPT_PERIOD_ID = vrptperiod_id
			  AND sbs.STATUS_CD = 'COMPLETE'
			  AND sbq.STATUS_CD = 'COMPLETE'
			  AND sbq.COMPLETED_TIME IS NOT NULL
		  ), '-infinity'::timestamp)
	) INTO vEVALUATION_OCCURRED;

	IF NOT vEVALUATION_OCCURRED THEN
		RETURN NEXT;
	END IF;
			 
	-- Delete the check session for this MP/RPT Period		
	DELETE FROM camdecmpswks.CHECK_SESSION cs
		WHERE EXISTS
		(SELECT 1 FROM camdecmpswks.EMISSION_EVALUATION ee
		 where ee.CHK_SESSION_ID = cs.CHK_SESSION_ID
		   and ee.MON_PLAN_ID=vmonplan_id
		   and ee.RPT_PERIOD_ID=vrptperiod_id
		   and ee.CHK_SESSION_ID IS NOT NULL);
			 
		-- Clear the eval
	UPDATE camdecmpswks.EMISSION_EVALUATION
		SET NEEDS_EVAL_FLG = 'Y',
			EVAL_STATUS_CD = 'EVAL',
			CHK_SESSION_ID = null
		where MON_PLAN_ID = vmonplan_id 
		  and RPT_PERIOD_ID = vrptperiod_id;			
		
	-- Now, clear all the calculated fields in tables		
	UPDATE camdecmpswks.DAILY_CALIBRATION dc
	 	SET CALC_ONLINE_OFFLINE_IND = null,
			CALC_ZERO_APS_IND = null,
			CALC_ZERO_CAL_ERROR = null,
			CALC_UPSCALE_APS_IND = null,
			CALC_UPSCALE_CAL_ERROR = null
		where exists
		 (select 1
			 from camdecmpswks.DAILY_TEST_SUMMARY dts
			   where dts.DAILY_TEST_SUM_ID = dc.DAILY_TEST_SUM_ID
				 and dts.RPT_PERIOD_ID= vrptperiod_id
				 and dts.MON_LOC_ID  = ANY(vMON_LOC_ID_LIST));
				 
    UPDATE camdecmpswks.DAILY_TEST_SUMMARY 
		SET CALC_TEST_RESULT_CD = null
		where RPT_PERIOD_ID= vrptperiod_id
		  and MON_LOC_ID  = ANY(vMON_LOC_ID_LIST);
				
	UPDATE camdecmpswks.DERIVED_HRLY_VALUE 
		SET CALC_UNADJUSTED_HRLY_VALUE = null,
			CALC_ADJUSTED_HRLY_VALUE = null,
			APPLICABLE_BIAS_ADJ_FACTOR = null,
			CALC_RATA_STATUS = null,
			CALC_APPE_STATUS = null
		where RPT_PERIOD_ID= vrptperiod_id
		  and MON_LOC_ID  = ANY(vMON_LOC_ID_LIST);

    UPDATE camdecmpswks.MONITOR_HRLY_VALUE 	
		SET CALC_ADJUSTED_HRLY_VALUE = null,
			APPLICABLE_BIAS_ADJ_FACTOR = null,
			CALC_LINE_STATUS = null,
			CALC_RATA_STATUS = null,
			CALC_DAYCAL_STATUS = null
		where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		  
		UPDATE camdecmpswks.SUMMARY_VALUE
		 SET CALC_CURRENT_RPT_PERIOD_TOTAL = null,
			 CALC_YEAR_TOTAL = null,		
			 CALC_OS_TOTAL = null
		where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		UPDATE camdecmpswks.HRLY_FUEL_FLOW
		SET CALC_VOLUMETRIC_FLOW_RATE = null,
			CALC_MASS_FLOW_RATE = null,
			CALC_APPD_STATUS = null
		  where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		UPDATE camdecmpswks.HRLY_PARAM_FUEL_FLOW
		SET CALC_PARAM_VAL_FUEL = null,
			CALC_APPE_STATUS = null
		 where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		  
		UPDATE camdecmpswks.LONG_TERM_FUEL_FLOW
		SET CALC_TOTAL_HEAT_INPUT = null
		   where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		-- RGGI field
		UPDATE camdecmpswks.DAILY_EMISSION
		SET CALC_TOTAL_DAILY_EMISSION = null
		  where MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		-- RGGI table/field
      UPDATE camdecmpswks.DAILY_FUEL df
		SET CALC_FUEL_CARBON_BURNED = null
		where exists
		 (select 1 from camdecmpswks.DAILY_EMISSION de
		   where de.DAILY_EMISSION_id = df.DAILY_EMISSION_id
		    and de.MON_LOC_ID  = ANY(vMON_LOC_ID_LIST)
		    and de.RPT_PERIOD_ID= vrptperiod_id);
	
	--Remove error codes and calculated values from pre-rendered View Emissions tables.
	 select * into result, error_msg 
	   from camdecmpswks.emissions_grid_remove_eval(vmonplan_id, vrptperiod_id );	
	
	RETURN NEXT; -- Add row to return table.

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F'; 
	error_msg :='From delete_calculated_em_data_from_workspace '||' '|| error_msg;
	
    RETURN NEXT; -- Add row to return table.
END;
$BODY$;
