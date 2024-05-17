CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_co2calc(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  dhvParamCodes text[] := ARRAY['CO2C','H2O'];
  mhvParamCodes text[] := ARRAY['H2O'];
  mhvMoistureParams text[] := ARRAY['O2C'];
  mhvMoistureCodes text[] := ARRAY['D', 'W'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_CO2CALC
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_CO2CALC(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		CO2C_MODC,
		CO2C_PMA,
		RPT_PCT_O2,
		PCT_O2_USED,
		O2_MODC,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		FC_FACTOR,
		FD_FACTOR,
		FORMULA_CD,
		RPT_PCT_CO2,
		CALC_PCT_CO2,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME,	
		dhv.CO2C_MODC_CD AS CO2C_MODC,
		dhv.CO2C_PCT_AVAILABLE AS CO2C_PMA,
		CASE (mf.EQUATION_CD)
			WHEN 'F-14A' THEN mhv.O2C_D_UNADJUSTED_HRLY_VALUE
			WHEN 'F-14B' THEN mhv.O2C_W_UNADJUSTED_HRLY_VALUE
		END AS RPT_PCT_O2,
		dhv.CO2C_CALC_PCT_DILUENT AS PCT_O2_USED,
		CASE (mf.EQUATION_CD)
			WHEN 'F-14A' THEN mhv.O2C_D_MODC_CD
			WHEN 'F-14B' THEN mhv.O2C_W_MODC_CD
		END AS O2_MODC,
		dhv.CO2C_CALC_PCT_MOISTURE AS PCT_H2O_USED,
		CASE 
			WHEN (dhv.CO2C_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (dhv.H2O_HOUR_ID IS NOT NULL) THEN dhv.H2O_MODC_CD
					WHEN (mhv.H2O_HOUR_ID IS NOT NULL) THEN mhv.H2O_MODC_CD
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		hod.FC_FACTOR AS FC_FACTOR,
		hod.FD_FACTOR AS FD_FACTOR,
		mf.EQUATION_CD AS FORMULA_CD,
		dhv.CO2C_ADJUSTED_HRLY_VALUE AS RPT_PCT_CO2,
		dhv.CO2C_CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_CO2,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			co2c_hour_id character varying,
			co2c_mon_sys_id character varying,
			co2c_mon_form_id character varying,
			co2c_adjusted_hrly_value numeric,
			co2c_calc_adjusted_hrly_value numeric,
			co2c_unadjusted_hrly_value numeric,
			co2c_calc_unadjusted_hrly_value numeric,
			co2c_applicable_bias_adj_factor numeric,
			co2c_calc_pct_moisture numeric,
			co2c_calc_pct_diluent numeric,
			co2c_pct_available numeric,
			co2c_segment_num numeric,
			co2c_operating_condition_cd character varying,
			co2c_fuel_cd character varying,
			co2c_modc_cd character varying,
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
	JOIN camdecmpswks.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		h2o_hour_id character varying,
		h2o_adjusted_hrly_value numeric,
		h2o_calc_adjusted_hrly_value numeric,
		h2o_unadjusted_hrly_value numeric,
		h2o_applicable_bias_adj_factor numeric,
		h2o_pct_available numeric,
		h2o_moisture_basis character varying,
		h2o_modc_cd character varying,
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
	LEFT JOIN camdecmpswks.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = dhv.CO2C_MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_DEFAULT AS md_H2O
		ON md_H2O.MON_LOC_ID = hod.MON_LOC_ID
		AND md_H2O.DEFAULT_PURPOSE_CD = 'PM'
		AND md_H2O.PARAMETER_CD = 'H2O'
		AND camdecmpswks.emissions_monitor_default_active(md_H2O.BEGIN_DATE, md_H2O.BEGIN_HOUR, md_H2O.END_DATE, md_H2O.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1
	where dhv.co2c_hour_id is not null;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2CALC');
END
$procedure$
