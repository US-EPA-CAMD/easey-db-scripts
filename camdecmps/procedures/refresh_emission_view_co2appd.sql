DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_co2appd(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2appd(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['CO2'];
  hpffParamCodes text[] :=   ARRAY['HI','CO2','FC'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_CO2APPD
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_CO2APPD(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		FUEL_TYPE,
		FUEL_USE_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		CALC_HI_RATE,
		FC_FACTOR,
		FORMULA_CD,
		RPT_CO2_MASS_RATE,
		CALC_CO2_MASS_RATE,
		SUMMATION_FORMULA_CD,
		RPT_CO2_MASS_RATE_ALL_FUELS,
		CALC_CO2_MASS_RATE_ALL_FUELS,
		ERROR_CODES
	)
	SELECT 
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME,
		COALESCE(ms.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		hff.FUEL_CD AS FUEL_TYPE,
		hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		hpff.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		hpff.FC_PARAM_VAL_FUEL AS FC_FACTOR,
		mf_hpff.EQUATION_CD AS FORMULA_CD,
		hpff.CO2_PARAM_VAL_FUEL AS RPT_CO2_MASS_RATE,
		hpff.CO2_CALC_PARAM_VAL_FUEL AS CALC_CO2_MASS_RATE,
		mf_dhv.EQUATION_CD AS SUMMATION_FORMULA_CD,
		dhv.CO2_ADJUSTED_HRLY_VALUE AS RPT_CO2_MASS_RATE_ALL_FUELS,
		dhv.CO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_CO2_MASS_RATE_ALL_FUELS,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.HRLY_FUEL_FLOW hff
		ON hff.HOUR_ID = hod.HOUR_ID
		AND hff.MON_LOC_ID = hod.MON_LOC_ID
		AND hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	JOIN camdecmps.get_derived_hourly_values_pivoted(
	  vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		co2_hour_id character varying,
		co2_mon_form_id character varying,
		co2_adjusted_hrly_value numeric,
		co2_calc_adjusted_hrly_value numeric,
		co2_unadjusted_hrly_value numeric,
		co2_calc_unadjusted_hrly_value numeric,
		co2_applicable_bias_adj_factor numeric,
		co2_calc_pct_moisture numeric,
		co2_calc_pct_diluent numeric,
		co2_pct_available numeric,
		co2_segment_num numeric,
		co2_operating_condition_cd character varying,
		co2_fuel_cd character varying,
		co2_modc_cd character varying
	)	ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	JOIN camdecmps.get_hourly_param_fuel_flow_pivoted(
	  vmonplanid, vrptperiodid, hpffParamCodes
	) AS hpff (
		hrly_fuel_flow_id character varying,
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		hi_hrly_fuel_flow_id character varying,
		hi_mon_form_id character varying,
		hi_param_val_fuel numeric,
		hi_calc_param_val_fuel numeric,
		hi_segment_num numeric,
		hi_sample_type_cd character varying,
		hi_parameter_uom_cd character varying,
		hi_operating_condition_cd character varying,
		co2_hrly_fuel_flow_id character varying,
		co2_mon_form_id character varying,
		co2_param_val_fuel numeric,
		co2_calc_param_val_fuel numeric,
		co2_segment_num numeric,
		co2_sample_type_cd character varying,
		co2_parameter_uom_cd character varying,
		co2_operating_condition_cd character varying,
		fc_hrly_fuel_flow_id character varying,
		fc_mon_form_id character varying,
		fc_param_val_fuel numeric,
		fc_calc_param_val_fuel numeric,
		fc_segment_num numeric,
		fc_sample_type_cd character varying,
		fc_parameter_uom_cd character varying,
		fc_operating_condition_cd character varying
	)	ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff.HOUR_ID = hff.HOUR_ID
		AND hpff.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_SYSTEM AS ms
		ON ms.MON_SYS_ID = hff.MON_SYS_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA mf_dhv
		ON mf_dhv.MON_FORM_ID = dhv.CO2_MON_FORM_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA mf_hpff
		ON mf_hpff.MON_FORM_ID = hpff.CO2_MON_FORM_ID
	WHERE EXISTS (
		SELECT 1
		FROM camdecmps.DERIVED_HRLY_VALUE
		WHERE HOUR_ID = dhv.HOUR_ID
		AND MON_LOC_ID = dhv.MON_LOC_ID
		AND RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
		AND PARAMETER_CD = ANY(dhvParamCodes)
	) OR EXISTS (
		SELECT 1
		FROM camdecmps.HRLY_PARAM_FUEL_FLOW
		WHERE HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND MON_LOC_ID = hff.MON_LOC_ID
		AND RPT_PERIOD_ID = hff.RPT_PERIOD_ID
		AND PARAMETER_CD = ANY(hpffParamCodes)
	)
	ORDER BY MON_LOC_ID, DATE_HOUR;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2APPD');
END
$BODY$;

-- ORIGINAL WHERE BUT THE EXISTS WAY ABOVE IS A BETTER WAY
-- 	WHERE hpff.CO2_HRLY_FUEL_FLOW_ID IS NOT NULL OR (
-- 		hpff.CO2_HRLY_FUEL_FLOW_ID IS NULL AND (
-- 			hpff.HI_HRLY_FUEL_FLOW_ID IS NOT NULL AND dhv.CO2_HOUR_ID IS NOT NULL
-- 		)
-- 	)

/*
----------------------------------------------------------------------------------------
FOR TESTING PURPOSES ONLY
----------------------------------------------------------------------------------------
DROP TABLE temp_hourly_test_errors;
CALL camdecmps.load_temp_hourly_test_errors('TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120);

select a.mon_plan_id, *
from camdecmps.monitor_plan_location a
--TRIED TO WRITE THIS BUT NOTHING PERFORMS GOOD BUT THE MP/RPT PERIOD ABOVE HAS DATA
order by a.mon_loc_id
*/