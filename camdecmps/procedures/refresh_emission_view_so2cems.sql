-- PROCEDURE: camdecmps.refresh_emission_view_so2cems(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_so2cems(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_so2cems(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['SO2','H2O','HI','SO2R'];
  mhvParamCodes text[] := ARRAY['FLOW','SO2C','H2O'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
  CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_SO2CEMS 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_SO2CEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		UNADJ_SO2,
		SO2_BAF,
		RPT_ADJ_SO2,
		CALC_ADJ_SO2,
		SO2_MODC,
		SO2_PMA,
		UNADJ_FLOW,
		FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		SO2_FORMULA_CD,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		CALC_HI_RATE,
		DEFAULT_SO2_EMISSION_RATE,
		ERROR_CODES
	)
	SELECT DISTINCT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME, 
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		mhv.SO2C_UNADJUSTED_HRLY_VALUE AS UNADJ_SO2, 
		mhv.SO2C_APPLICABLE_BIAS_ADJ_FACTOR AS SO2_BAF, 
		mhv.SO2C_ADJUSTED_HRLY_VALUE AS RPT_ADJ_SO2, 
		mhv.SO2C_CALC_ADJUSTED_HRLY_VALUE  AS CALC_ADJ_SO2, 
		mhv.SO2C_MODC_CD AS SO2_MODC, 
		mhv.SO2C_PCT_AVAILABLE AS SO2_PMA,
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
		mhv.FLOW_APPLICABLE_BIAS_ADJ_FACTOR AS FLOW_BAF, 
		mhv.FLOW_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
		mhv.FLOW_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED, 
		mhv.FLOW_MODC_CD AS FLOW_MODC, 
		mhv.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		dhv.SO2_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE 
			WHEN (dhv.SO2_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (dhv.H2O_MODC_CD IS NOT NULL) THEN dhv.H2O_MODC_CD 
					WHEN (mhv.H2O_MODC_CD IS NOT NULL) THEN mhv.H2O_MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		mf.EQUATION_CD AS SO2_FORMULA_CD, 
		dhv.SO2_ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS_RATE, 
		dhv.SO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS_RATE, 
		CASE (mf.EQUATION_CD) WHEN 'F-23' THEN dhv.HI_CALC_ADJUSTED_HRLY_VALUE END AS CALC_HI_RATE, 
		CASE (mf.EQUATION_CD) WHEN 'F-23' THEN Coalesce(dhv.SO2R_ADJUSTED_HRLY_VALUE, camdecmps.emissions_get_default_so2_rate(hod.MON_LOC_ID, hod.BEGIN_DATE, hod.BEGIN_HOUR)) END AS DEFAULT_SO2_EMISSION_RATE,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
		vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		so2_hour_id character varying,
		so2_mon_form_id character varying,
		so2_adjusted_hrly_value numeric,
		so2_calc_adjusted_hrly_value numeric,
		so2_unadjusted_hrly_value numeric,
		so2_calc_unadjusted_hrly_value numeric,
		so2_applicable_bias_adj_factor numeric,
		so2_calc_pct_moisture numeric,
		so2_calc_pct_diluent numeric,
		so2_pct_available numeric,
		so2_segment_num numeric,
		so2_operating_condition_cd character varying,
		so2_fuel_cd character varying,
		so2_modc_cd character varying,
		h2o_hour_id character varying,
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
		h2o_modc_cd character varying,
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
		hi_modc_cd character varying,
		so2r_hour_id character varying,
		so2r_mon_form_id character varying,
		so2r_adjusted_hrly_value numeric,
		so2r_calc_adjusted_hrly_value numeric,
		so2r_unadjusted_hrly_value numeric,
		so2r_calc_unadjusted_hrly_value numeric,
		so2r_applicable_bias_adj_factor numeric,
		so2r_calc_pct_moisture numeric,
		so2r_calc_pct_diluent numeric,
		so2r_pct_available numeric,
		so2r_segment_num numeric,
		so2r_operating_condition_cd character varying,
		so2r_fuel_cd character varying,
		so2r_modc_cd character varying
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
		flow_modc_cd character varying,
		so2c_hour_id character varying,
		so2c_adjusted_hrly_value numeric,
		so2c_calc_adjusted_hrly_value numeric,
		so2c_unadjusted_hrly_value numeric,
		so2c_applicable_bias_adj_factor numeric,
		so2c_pct_available numeric,
		so2c_moisture_basis character varying,
		so2c_modc_cd character varying,
		h2o_hour_id character varying,
		h2o_adjusted_hrly_value numeric,
		h2o_calc_adjusted_hrly_value numeric,
		h2o_unadjusted_hrly_value numeric,
		h2o_applicable_bias_adj_factor numeric,
		h2o_pct_available numeric,
		h2o_moisture_basis character varying,
		h2o_modc_cd character varying
	) ON mhv.HOUR_ID = hod.HOUR_ID
	  AND mhv.MON_LOC_ID = hod.MON_LOC_ID
	  AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA  mf 
		ON dhv.SO2_MON_FORM_ID = mf.MON_FORM_ID
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT  md_H2O 
		ON HOD.MON_LOC_ID = md_H2O.MON_LOC_ID AND md_H2O.DEFAULT_PURPOSE_CD = 'PM' AND md_H2O.PARAMETER_CD = 'H2O' 
		AND (camdecmps.emissions_monitor_default_active(md_H2O.BEGIN_DATE, md_H2O.BEGIN_HOUR, md_H2O.END_DATE, md_H2O.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SO2CEMS');
END
$BODY$;
