DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_noxmasscems(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxmasscems(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  mhvParamCodes text[] := ARRAY['FLOW','NOXC','H2O'];
  dhvParamCodes text[] := ARRAY['NOX','H2O','NOXR'];
BEGIN
	RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXMASSCEMS
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

	RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXMASSCEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		UNADJ_NOX,
		CALC_NOX_BAF,
		RPT_ADJ_NOX,
		ADJ_NOX_USED,
		NOX_MODC,
		NOX_PMA,
		UNADJ_FLOW,
		CALC_FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		NOX_MASS_FORMULA_CD,
		RPT_NOX_MASS,
		CALC_NOX_MASS,
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
		mhv.NOXC_UNADJUSTED_HRLY_VALUE AS UNADJ_NOX,
		mhv.NOXC_APPLICABLE_BIAS_ADJ_FACTOR AS CALC_NOX_BAF,
		mhv.NOXC_ADJUSTED_HRLY_VALUE AS RPT_ADJ_NOX,
		mhv.NOXC_CALC_ADJUSTED_HRLY_VALUE AS ADJ_NOX_USED,
		mhv.NOXC_MODC_CD AS NOX_MODC,
		mhv.NOXC_PCT_AVAILABLE AS NOX_PMA,
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW,
		mhv.FLOW_APPLICABLE_BIAS_ADJ_FACTOR AS CALC_FLOW_BAF,
		mhv.FLOW_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW,
		mhv.FLOW_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED,
		mhv.FLOW_MODC_CD AS FLOW_MODC,
		mhv.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		dhv.NOX_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE 
			WHEN (dhv.NOX_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (mhv.H2O_MODC_CD IS NOT NULL) THEN mhv.H2O_MODC_CD 
					WHEN (dhv.H2O_MODC_CD IS NOT NULL) THEN dhv.H2O_MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		mf.EQUATION_CD AS NOX_MASS_FORMULA_CD,
		dhv.NOX_ADJUSTED_HRLY_VALUE AS RPT_NOX_MASS,
		dhv.NOX_CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_MASS,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
		vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		nox_hour_id character varying,
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
		noxr_hour_id character varying,
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
		noxr_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
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
		noxc_hour_id character varying,
		noxc_adjusted_hrly_value numeric,
		noxc_calc_adjusted_hrly_value numeric,
		noxc_unadjusted_hrly_value numeric,
		noxc_applicable_bias_adj_factor numeric,
		noxc_pct_available numeric,
		noxc_moisture_basis character varying,
		noxc_modc_cd character varying,
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
	INNER JOIN camdecmps.MONITOR_FORMULA  MF 
		ON dhv.NOX_MON_FORM_ID = MF.MON_FORM_ID AND MF.EQUATION_CD LIKE 'F-26%'
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT  md_H2O 
		ON hod.MON_LOC_ID = md_H2O.MON_LOC_ID AND md_H2O.DEFAULT_PURPOSE_CD = 'PM' AND md_H2O.PARAMETER_CD = 'H2O' 
		AND camdecmps.emissions_monitor_default_active(md_H2O.BEGIN_DATE, md_H2O.BEGIN_HOUR, md_H2O.END_DATE, md_H2O.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXMASSCEMS');
END
$BODY$;
