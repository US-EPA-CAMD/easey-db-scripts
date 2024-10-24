CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_all(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
  mhvParamCodes text[] := ARRAY['FLOW'];
  dhvParamCodes text[] := ARRAY['HI','SO2','NOXR','NOX', 'CO2'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_ALL
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_ALL(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		HOUR_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		HI_FORMULA_cd,
		RPT_HI_RATE,
		CALC_HI_RATE,
		SO2_FORMULA_cd,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		nox_rate_formula_cd,
		RPT_ADJ_NOX_RATE,
		CALC_ADJ_NOX_RATE,
		nox_mass_formula_cd,
		RPT_NOX_MASS,
		CALC_NOX_MASS,
		CO2_FORMULA_cd,
		RPT_CO2_MASS_RATE,
		CALC_CO2_MASS_RATE,
		ADJ_FLOW_USED,
		RPT_ADJ_FLOW,
		UNADJ_FLOW,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		hod.HOUR_ID,
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME,
		hod.HR_LOAD,
		hod.LOAD_UOM_CD,
		mf_hi.EQUATION_CD,
		dhv.HI_ADJUSTED_HRLY_VALUE,
		dhv.HI_CALC_ADJUSTED_HRLY_VALUE,
		mf_SO2.EQUATION_CD,
		dhv.SO2_ADJUSTED_HRLY_VALUE,
		dhv.SO2_CALC_ADJUSTED_HRLY_VALUE,
		mf_NOXR.EQUATION_CD,
		dhv.NOXR_ADJUSTED_HRLY_VALUE,
		dhv.NOXR_CALC_ADJUSTED_HRLY_VALUE,
		mf_NOX.EQUATION_CD,
		dhv.NOX_ADJUSTED_HRLY_VALUE,
		dhv.NOX_CALC_ADJUSTED_HRLY_VALUE,
		mf_CO2.EQUATION_CD,
		dhv.CO2_ADJUSTED_HRLY_VALUE,
		dhv.CO2_CALC_ADJUSTED_HRLY_VALUE,
		mhv.FLOW_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED,
		mhv.FLOW_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	LEFT JOIN camdecmpswks.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			hi_hour_id character varying,
			hi_mon_sys_id character varying,
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
			so2_hour_id character varying,
			so2_mon_sys_id character varying,
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
			noxr_hour_id character varying,
			noxr_mon_sys_id character varying,
			noxr_mon_form_id character varying,
			noxr_adjusted_hrly_value numeric,
			noxr_calc_adjusted_hrly_value numeric,
			noxr_unadjusted_hrly_value numeric,
			noxr_calc_unadjusted_hrly_value numeric,
			noxr_applicable_bias_adj_factor numeric,
			noxr_calc_pct_moisture numeric,
			noxr_calc_pct_diluent numeric,
			noxr_pct_available numeric,
			noxr_segment_num numeric,
			noxr_operating_condition_cd character varying,
			noxr_fuel_cd character varying,
			noxr_modc_cd character varying,
			nox_hour_id character varying,
			nox_mon_sys_id character varying,
			nox_mon_form_id character varying,
			nox_adjusted_hrly_value numeric,
			nox_calc_adjusted_hrly_value numeric,
			nox_unadjusted_hrly_value numeric,
			nox_calc_unadjusted_hrly_value numeric,
			nox_applicable_bias_adj_factor numeric,
			nox_calc_pct_moisture numeric,
			nox_calc_pct_diluent numeric,
			nox_pct_available numeric,
			nox_segment_num numeric,
			nox_operating_condition_cd character varying,
			nox_fuel_cd character varying,
			nox_modc_cd character varying,
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
			co2_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	left JOIN camdecmpswks.get_monitor_hourly_values_pivoted(
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
		flow_modc_cd character varying
	)	ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_HI
		ON mf_HI.MON_FORM_ID = dhv.HI_MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_SO2
		ON mf_SO2.MON_FORM_ID = dhv.SO2_MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_NOXR
		ON mf_NOXR.MON_FORM_ID = dhv.NOXR_MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_NOX
		ON mf_NOX.MON_FORM_ID = dhv.NOX_MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_CO2
		ON mf_CO2.MON_FORM_ID = dhv.CO2_MON_FORM_ID
	where dhv.hi_hour_id is not null or dhv.so2_hour_id is not null or dhv.noxr_hour_id is not null or dhv.nox_hour_id is not null or dhv.co2_hour_id is not null
	or mhv.flow_hour_id is not null;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'ALL');
END
$procedure$
