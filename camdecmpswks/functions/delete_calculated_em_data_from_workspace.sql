-- FUNCTION: camdecmpswks.delete_calculated_em_data_from_workspace(character varying, integer)

-- DROP FUNCTION IF EXISTS camdecmpswks.delete_calculated_em_data_from_workspace(character varying, integer);

CREATE OR REPLACE FUNCTION camdecmpswks.delete_calculated_em_data_from_workspace(
	vmonplan_id character varying,
	vrptperiod_id integer)
    RETURNS TABLE(result text, error_msg character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare 
    
BEGIN
    error_msg := '';
    result := 'T';	 

	 create temp table tmpMonInfo(MON_PLAN_ID character varying,
	          MON_LOC_ID character varying, RPT_PERIOD_ID int);
	
         ----- Get the MON_LOC_IDs for this MP
	insert into tmpMonInfo
		SELECT distinct vmonplan_id, MON_LOC_ID, vrptperiod_id
	    	FROM camdecmpswks.MONITOR_PLAN_LOCATION 
			 where MON_PLAN_ID = vmonplan_id;
			 
	-- Delete the check session for this MP/RPT Period		
	DELETE FROM camdecmpswks.CHECK_SESSION 
		WHERE CHK_SESSION_ID IN 
		(SELECT CHK_SESSION_ID FROM camdecmpswks.EMISSION_EVALUATION 
		 where MON_PLAN_ID=vmonplan_id 
		   and RPT_PERIOD_ID=vrptperiod_id
		   and CHK_SESSION_ID IS NOT NULL);	
			 
		-- Clear the eval
	UPDATE camdecmpswks.EMISSION_EVALUATION
		SET NEEDS_EVAL_FLG = 'Y',
			CHK_SESSION_ID = null
		where MON_PLAN_ID = vmonplan_id 
		  and RPT_PERIOD_ID = vrptperiod_id;			
		
	-- Now, clear all the calculated fields in tables		
	UPDATE camdecmpswks.DAILY_CALIBRATION	
	 	SET CALC_ONLINE_OFFLINE_IND = null,
			CALC_ZERO_APS_IND = null,
			CALC_ZERO_CAL_ERROR = null,
			CALC_UPSCALE_APS_IND = null,
			CALC_UPSCALE_CAL_ERROR = null
		where DAILY_TEST_SUM_ID in
		 (select distinct DAILY_TEST_SUM_ID
			 from camdecmpswks.DAILY_TEST_SUMMARY 
			   where RPT_PERIOD_ID= vrptperiod_id
				 and MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo));
				 
    UPDATE camdecmpswks.DAILY_TEST_SUMMARY 
		SET CALC_TEST_RESULT_CD = null
		where RPT_PERIOD_ID= vrptperiod_id
		  and MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo);
				
	UPDATE camdecmpswks.DERIVED_HRLY_VALUE 
		SET CALC_UNADJUSTED_HRLY_VALUE = null,
			CALC_ADJUSTED_HRLY_VALUE = null,
			APPLICABLE_BIAS_ADJ_FACTOR = null,
			CALC_RATA_STATUS = null,
			CALC_APPE_STATUS = null
		where RPT_PERIOD_ID= vrptperiod_id
		  and MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo);

    UPDATE camdecmpswks.MONITOR_HRLY_VALUE 	
		SET CALC_ADJUSTED_HRLY_VALUE = null,
			APPLICABLE_BIAS_ADJ_FACTOR = null,
			CALC_LINE_STATUS = null,
			CALC_RATA_STATUS = null,
			CALC_DAYCAL_STATUS = null
		where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		  
		UPDATE camdecmpswks.SUMMARY_VALUE
		 SET CALC_CURRENT_RPT_PERIOD_TOTAL = null,
			 CALC_YEAR_TOTAL = null,		
			 CALC_OS_TOTAL = null
		where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		UPDATE camdecmpswks.HRLY_FUEL_FLOW
		SET CALC_VOLUMETRIC_FLOW_RATE = null,
			CALC_MASS_FLOW_RATE = null,
			CALC_APPD_STATUS = null
		  where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		UPDATE camdecmpswks.HRLY_PARAM_FUEL_FLOW
		SET CALC_PARAM_VAL_FUEL = null,
			CALC_APPE_STATUS = null
		 where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		  
		UPDATE camdecmpswks.LONG_TERM_FUEL_FLOW
		SET CALC_TOTAL_HEAT_INPUT = null
		   where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		-- RGGI field
		UPDATE camdecmpswks.DAILY_EMISSION
		SET CALC_TOTAL_DAILY_EMISSION = null
		  where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		  and RPT_PERIOD_ID= vrptperiod_id;
		
		-- RGGI table/field
      UPDATE camdecmpswks.DAILY_FUEL
		SET CALC_FUEL_CARBON_BURNED = null
		where DAILY_EMISSION_id in
		 (select distinct DAILY_EMISSION_id from camdecmpswks.DAILY_EMISSION
		   where MON_LOC_ID in (select distinct MON_LOC_ID from tmpMonInfo)
		    and RPT_PERIOD_ID= vrptperiod_id);
		  
	-- Delete rows for DM_EMISSIONS and its child tables
   	DELETE FROM camdecmps.DM_EMISSIONS
		WHERE MON_PLAN_ID = vmonplan_id
		  and RPT_PERIOD_ID=vrptperiod_id;
	
	--Remove error codes and calculated values from pre-rendered View Emissions tables.
	 select * into result, error_msg 
	   from camdecmpswks.emissions_grid_remove_eval(vmonplan_id, vrptperiod_id );	
	
	 return next;

exception when others then
    get stacked diagnostics error_msg := message_text;
    result = 'F'; 
	error_msg :='From delete_calculated_em_data_from_workspace '||' '|| message_text;
	
   return next;
END;
$BODY$;


