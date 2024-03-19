DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_noxappesinglefuel(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxappesinglefuel(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['NOXR','HI','NOX'];
  hpffParamCodes text[] := ARRAY['NOXR','HI'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXAPPESINGLEFUEL(
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
		OPERATING_CONDITION_CD,
		SEGMENT_NUMBER,
		APP_E_SYS_ID,
		RPT_NOX_EMISSION_RATE,
		CALC_NOX_EMISSION_RATE,
		SUMMATION_FORMULA_CD,
		RPT_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_NOX_EMISSION_RATE_ALL_FUELS,
		CALC_HI_RATE_ALL_FUELS,
		NOX_MASS_RATE_FORMULA_CD,
		RPT_NOX_MASS_ALL_FUELS,
		CALC_NOX_MASS_ALL_FUELS,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME,
		COALESCE(MS.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		hff.FUEL_CD AS FUEL_TYPE,
		hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		hpff_HI.CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		hpff_NOXR.OPERATING_CONDITION_CD,
		hpff_NOXR.SEGMENT_NUM AS SEGMENT_NUMBER,
		ms_NOXR.SYSTEM_IDENTIFIER AS APP_E_SYS_ID,
		hpff_NOXR.PARAM_VAL_FUEL AS RPT_NOX_EMISSION_RATE,
		hpff_NOXR.CALC_PARAM_VAL_FUEL AS CALC_NOX_EMISSION_RATE,
		mf_NOXR.EQUATION_CD AS SUMMATION_FORMULA_CD,
		dhv_NOXR.ADJUSTED_HRLY_VALUE AS RPT_NOX_EMISSION_RATE_ALL_FUELS,
		dhv_NOXR.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_EMISSION_RATE_ALL_FUELS,
		CASE 
			WHEN (dhv_NOX.HOUR_ID IS NOT NULL) THEN dhv_HI.CALC_ADJUSTED_HRLY_VALUE
		END AS CALC_HI_RATE_ALL_FUELS,
		mf_NOX.EQUATION_CD AS NOX_MASS_RATE_FORMULA_CD,
		dhv_NOX.ADJUSTED_HRLY_VALUE AS RPT_NOX_MASS_ALL_FUELS,
		dhv_NOX.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_MASS_ALL_FUELS,
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
		noxr_modc_cd character varying,
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
		nox_modc_cd character varying
	)ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	JOIN camdecmps.get_hourly_param_fuel_flow_pivoted(
	  vmonplanid, vrptperiodid, hpffParamCodes
	) AS hpff (
		hrly_fuel_flow_id character varying,
        hour_id character varying,
        mon_loc_id character varying,
        rpt_period_id numeric,
		noxr_hrly_fuel_flow_id character varying,
        noxr_mon_form_id character varying,
        noxr_param_val_fuel numeric,
        noxr_calc_param_val_fuel numeric,
        noxr_segment_num numeric,
        noxr_sample_type_cd character varying,
        noxr_parameter_uom_cd character varying,
        noxr_operating_condition_cd character varying,
		hi_hrly_fuel_flow_id character varying,
        hi_mon_form_id character varying,
        hi_param_val_fuel numeric,
        hi_calc_param_val_fuel numeric,
        hi_segment_num numeric,
        hi_sample_type_cd character varying,
        hi_parameter_uom_cd character varying,
        hi_operating_condition_cd character varying
	)ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_SYSTEM ms 
		ON hff.MON_SYS_ID = ms.MON_SYS_ID
	LEFT JOIN camdecmps.MONITOR_SYSTEM ms_NOXR 
		ON hpff_NOXR.MON_SYS_ID = ms_NOXR.MON_SYS_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA mf_NOXR 
		ON dhv_NOXR.MON_FORM_ID = mf_NOXR.MON_FORM_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA mf_NOX 
		ON dhv_NOX.MON_FORM_ID = mf_NOX.MON_FORM_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPESINGLEFUEL');
END
$BODY$;
