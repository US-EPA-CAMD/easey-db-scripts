CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_noxappesinglefuel(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
declare 
	dhvParamCodes text[] := ARRAY['NOXR', 'HI', 'NOX'];
	hpffParamCodes text[] := ARRAY['NOXR', 'HI'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_NOXAPPESINGLEFUEL
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_NOXAPPESINGLEFUEL(
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
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID,
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		HOD.OP_TIME,
		COALESCE(MS.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		HFF.FUEL_CD AS FUEL_TYPE,
		HFF.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		HPFF.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		HPFF.NOXR_OPERATING_CONDITION_CD,
		HPFF.NOXR_SEGMENT_NUM AS SEGMENT_NUMBER,
		MS_NOXR.SYSTEM_IDENTIFIER AS APP_E_SYS_ID,
		HPFF.NOXR_PARAM_VAL_FUEL AS RPT_NOX_EMISSION_RATE,
		HPFF.NOXR_CALC_PARAM_VAL_FUEL AS CALC_NOX_EMISSION_RATE,
		NOXR_MF.EQUATION_CD AS SUMMATION_FORMULA_CD,
		DHV.NOXR_ADJUSTED_HRLY_VALUE AS RPT_NOX_EMISSION_RATE_ALL_FUELS,
		DHV.NOXR_CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_EMISSION_RATE_ALL_FUELS,
		CASE 
			WHEN (DHV.NOXR_HOUR_ID IS NOT NULL) THEN DHV.HI_CALC_ADJUSTED_HRLY_VALUE
		END AS CALC_HI_RATE_ALL_FUELS,
		NOX_MF.EQUATION_CD AS NOX_MASS_RATE_FORMULA_CD,
		DHV.NOX_ADJUSTED_HRLY_VALUE AS RPT_NOX_MASS_ALL_FUELS,
		DHV.NOX_CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_MASS_ALL_FUELS,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	JOIN camdecmpswks.HRLY_FUEL_FLOW HFF 
		ON HFF.HOUR_ID = HOD.HOUR_ID
		AND HFF.MON_LOC_ID = HOD.MON_LOC_ID
		AND HFF.RPT_PERIOD_ID = HOD.RPT_PERIOD_ID	
	LEFT JOIN camdecmpswks.get_hourly_param_fuel_flow_pivoted(
	  vmonplanid, vrptperiodid, hpffParamCodes
	) AS hpff (
		hrly_fuel_flow_id character varying,
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		noxr_hrly_fuel_flow_id character varying,
		noxr_mon_sys_id character varying,
		noxr_mon_form_id character varying,
		noxr_param_val_fuel numeric,
		noxr_calc_param_val_fuel numeric,
		noxr_segment_num numeric,
		noxr_sample_type_cd character varying,
		noxr_parameter_uom_cd character varying,
		noxr_operating_condition_cd character varying,
		hi_hrly_fuel_flow_id character varying,
		hi_mon_sys_id character varying,
		hi_mon_form_id character varying,
		hi_param_val_fuel numeric,
		hi_calc_param_val_fuel numeric,
		hi_segment_num numeric,
		hi_sample_type_cd character varying,
		hi_parameter_uom_cd character varying,
		hi_operating_condition_cd character varying
	)   ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff.HOUR_ID = hff.HOUR_ID
		AND hpff.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
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
			nox_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_SYSTEM MS 
		ON HFF.MON_SYS_ID = MS.MON_SYS_ID
	LEFT JOIN camdecmpswks.MONITOR_SYSTEM MS_NOXR 
		ON HPFF.NOXR_MON_SYS_ID = MS_NOXR.MON_SYS_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA NOXR_MF 
		ON DHV.NOXR_MON_FORM_ID = NOXR_MF.MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA NOX_MF 
		ON DHV.NOX_MON_FORM_ID = NOX_MF.MON_FORM_ID
	WHERE hpff.noxr_hrly_fuel_flow_id is not null;

	


	


  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPESINGLEFUEL');
END
$procedure$
