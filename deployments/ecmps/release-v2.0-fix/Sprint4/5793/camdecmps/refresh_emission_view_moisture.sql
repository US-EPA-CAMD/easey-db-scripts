CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_moisture(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
    dhvParamCodes text[] := ARRAY['H2O'];
    mhvParamCodes text[] := ARRAY['O2C'];
    mhvMoistureParams text[] := ARRAY['O2C'];
    mhvMoistureCodes text[] := ARRAY['D', 'W'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_MOISTURE
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_MOISTURE(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		H2O_MODC,
		H2O_PMA,
		PCT_O2_WET,
		O2_WET_MODC,
		PCT_O2_DRY,
		O2_DRY_MODC,
		H2O_FORMULA_CD,
		RPT_PCT_H2O,
		CALC_PCT_H2O,
		ERROR_CODES
	)
	SELECT DISTINCT 
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME, 
		dhv.h2o_MODC_CD AS H2O_MODC,
		dhv.h2o_PCT_AVAILABLE AS H2O_PMA,
		mhv.o2c_w_UNADJUSTED_HRLY_VALUE AS PCT_O2_WET,
		mhv.o2c_w_MODC_CD AS O2_WET_MODC,
		mhv.o2c_d_UNADJUSTED_HRLY_VALUE AS PCT_O2_DRY,
		mhv.o2c_d_MODC_CD AS O2_DRY_MODC,
		mf.EQUATION_CD AS H2O_FORMULA_CD,
		dhv.h2o_ADJUSTED_HRLY_VALUE AS RPT_PCT_H2O,
		dhv.h2o_CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_H2O,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			h2o_hour_id character varying,
			h2o_mon_sys_id character varying,
			h2o_mon_form_id character varying,
			h2o_adjusted_hrly_value numeric,
			h2o_calc_adjusted_hrly_value numeric,
			h2o_unadjusted_hrly_value numeric,
			h2o_calc_unadjusted_hrly_value numeric,
			h2o_applicable_bias_adj_factor numeric,
			h2o_calc_pct_moisture numeric,
			h2o_calc_pct_diluent numeric,
			h2o_pct_available numeric,
			h2o_segment_num numeric,
			h2o_operating_condition_cd character varying,
			h2o_fuel_cd character varying,
			h2o_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = dhv.h2o_MON_FORM_ID 
	LEFT JOIN camdecmps.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		o2c_hour_id character varying,
		o2c_adjusted_hrly_value numeric,
		o2c_calc_adjusted_hrly_value numeric,
		o2c_unadjusted_hrly_value numeric,
		o2c_applicable_bias_adj_factor numeric,
		o2c_pct_available numeric,
		o2c_moisture_basis character varying,
		o2c_modc_cd character varying,
		o2c_d_hour_id character varying,
		o2c_d_adjusted_hrly_value numeric,
		o2c_d_calc_adjusted_hrly_value numeric,
		o2c_d_unadjusted_hrly_value numeric,
		o2c_d_applicable_bias_adj_factor numeric,
		o2c_d_pct_available numeric,
		o2c_d_moisture_basis character varying,
		o2c_d_modc_cd character varying,
		o2c_w_hour_id character varying,
		o2c_w_adjusted_hrly_value numeric,
		o2c_w_calc_adjusted_hrly_value numeric,
		o2c_w_unadjusted_hrly_value numeric,
		o2c_w_applicable_bias_adj_factor numeric,
		o2c_w_pct_available numeric,
		o2c_w_moisture_basis character varying,
		o2c_w_modc_cd character varying
	)	ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID		
	WHERE dhv.h2o_MODC_CD <> '40';

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MOISTURE');
END
$procedure$
