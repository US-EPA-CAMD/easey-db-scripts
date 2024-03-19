DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_hiunitstack(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_hiunitstack(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['HI'];
  mhvParamCodes text[] := ARRAY['FLOW'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_HIUNITSTACK
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_HIUNITSTACK(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		HI_FORMULA_CD,
		RPT_HI_RATE,
		CALC_HI_RATE,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME, 
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		hod.LOAD_RANGE, 
		hod.COMMON_STACK_LOAD_RANGE, 
		mf.EQUATION_CD AS HI_FORMULA_CD, 
		dhv.HI_ADJUSTED_HRLY_VALUE AS RPT_HI_RATE, 
		dhv.HI_CALC_ADJUSTED_HRLY_VALUE AS CALC_HI_RATE, 
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
		vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		hi_hour_id character varying,
		hi_mon_form_id character varying,
		hi_adjusted_hrly_value numeric,
		hi_calc_adjusted_hrly_value numeric,
		hi_unadjusted_hrly_value numeric,
		hi_calc_unadjusted_hrly_value numeric,
		hi_applicable_bias_adj_factor numeric,
		hi_calc_pct_moisture numeric,
		hi_calc_pct_diluent numeric,
		hi_pct_available numeric,
		hi_segment_num numeric,
		hi_operating_condition_cd character varying,
		hi_fuel_cd character varying,
		hi_modc_cd character varying
	)ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	JOIN camdecmps.get_monitor_hourly_values_pivoted(
		vmonplanid, vrptperiodid, mhvParamCodes
	) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		flow_hour_id character varying,
		flow_adjusted_hrly_value numeric,
		flow_calc_adjusted_hrly_value numeric,
		flow_unadjusted_hrly_value numeric,
		flow_applicable_bias_adj_factor numeric,
		flow_pct_available numeric,
		flow_moisture_basis character varying,
		flow_modc_cd character varying
	)ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA AS mf 
		ON dhv.HI_MON_FORM_ID = mf.MON_FORM_ID
  WHERE mhv.PARAMETER_CD IS NULL;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIUNITSTACK');
END
$BODY$;
