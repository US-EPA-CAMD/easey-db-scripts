CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2cems(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  dhvParamCodes text[] := ARRAY['CO2','CO2M','CO2C','H2O'];
  mhvParamCodes text[] := ARRAY['FLOW','CO2C','H2O'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_CO2CEMS
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_CO2CEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		COMPONENT_TYPE,
		RPT_PCT_CO2,
		PCT_CO2_USED,
		CO2_MODC,
		CO2_PMA,
		UNADJ_FLOW,
		CALC_FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		CO2_FORMULA_CD,
		RPT_CO2_MASS_RATE,
		CALC_CO2_MASS_RATE,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME, 
		hod.HR_LOAD AS UNIT_LOAD, 
        hod.LOAD_UOM_CD AS LOAD_UOM,
		CASE 
			WHEN (dhv.CO2C_HOUR_ID IS NOT NULL) THEN 'O2'
			WHEN (mhv.CO2C_HOUR_ID IS NOT NULL) THEN 'CO2'
			ELSE NULL
		END AS COMPONENT_TYPE,
		CASE 
			WHEN (dhv.CO2C_HOUR_ID IS NOT NULL) THEN dhv.CO2C_ADJUSTED_HRLY_VALUE
			WHEN (mhv.CO2C_HOUR_ID IS NOT NULL) THEN mhv.CO2C_UNADJUSTED_HRLY_VALUE
			ELSE NULL
		END AS RPT_PCT_CO2,
		dhv.CO2_CALC_PCT_DILUENT AS PCT_CO2_USED,
		CASE 
			WHEN (dhv.CO2C_HOUR_ID IS NOT NULL) THEN dhv.CO2C_MODC_CD
			WHEN (mhv.CO2C_HOUR_ID IS NOT NULL) THEN mhv.CO2C_MODC_CD
			ELSE NULL
		END AS CO2_MODC,
		CASE 
			WHEN (dhv.CO2C_HOUR_ID IS NOT NULL) THEN dhv.CO2C_PCT_AVAILABLE
			WHEN (mhv.CO2C_HOUR_ID IS NOT NULL) THEN mhv.CO2C_PCT_AVAILABLE
			ELSE NULL
		END AS CO2_PMA,
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW,
		mhv.FLOW_APPLICABLE_BIAS_ADJ_FACTOR AS CALC_FLOW_BAF,	
		mhv.FLOW_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW,
		mhv.FLOW_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED,
		mhv.FLOW_MODC_CD AS FLOW_MODC,
		mhv.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		dhv.CO2_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE
			WHEN (dhv.CO2_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE
					WHEN (dhv.H2O_MODC_CD IS NOT NULL) THEN dhv.H2O_MODC_CD 
					WHEN (mhv.H2O_MODC_CD IS NOT NULL) THEN mhv.H2O_MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE,
		mf.EQUATION_CD AS CO2_FORMULA_CD,
		dhv.CO2_ADJUSTED_HRLY_VALUE AS RPT_CO2_MASS_RATE,
		dhv.CO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_CO2_MASS_RATE,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			co2_hour_id character varying,
			co2_mon_sys_id character varying,
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
			co2_modc_cd character varying,
			co2m_hour_id character varying,
			co2m_mon_sys_id character varying,
			co2m_mon_form_id character varying,
			co2m_adjusted_hrly_value numeric,
			co2m_calc_adjusted_hrly_value numeric,
			co2m_unadjusted_hrly_value numeric,
			co2m_calc_unadjusted_hrly_value numeric,
			co2m_applicable_bias_adj_factor numeric,
			co2m_calc_pct_moisture numeric,
			co2m_calc_pct_diluent numeric,
			co2m_pct_available numeric,
			co2m_segment_num numeric,
			co2m_operating_condition_cd character varying,
			co2m_fuel_cd character varying,
			co2m_modc_cd character varying,
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
	JOIN camdecmps.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes) AS mhv (
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
		flow_modc_cd character varying,
		co2c_hour_id character varying,
		co2c_adjusted_hrly_value numeric,
		co2c_calc_adjusted_hrly_value numeric,
		co2c_unadjusted_hrly_value numeric,
		co2c_applicable_bias_adj_factor numeric,
		co2c_pct_available numeric,
		co2c_moisture_basis character varying,
		co2c_modc_cd character varying,
		h2o_hour_id character varying,
		h2o_adjusted_hrly_value numeric,
		h2o_calc_adjusted_hrly_value numeric,
		h2o_unadjusted_hrly_value numeric,
		h2o_applicable_bias_adj_factor numeric,
		h2o_pct_available numeric,
		h2o_moisture_basis character varying,
		h2o_modc_cd character varying
	)	ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = dhv.CO2_MON_FORM_ID
    WHERE dhv.co2_hour_id IS NOT NULL
      AND mhv.flow_hour_id IS NOT NULL;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2CEMS');
END
$procedure$
