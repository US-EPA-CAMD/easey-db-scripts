CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_so2appd(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
declare 
	dhvParamCodes text[] := ARRAY['SO2'];
	hpffParamCodes text[] := ARRAY['SO2', 'SULFUR', 'SO2R', 'HI'];
BEGIN
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmpswks.EMISSION_VIEW_SO2APPD 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_SO2APPD(
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
		CALC_FUEL_FLOW,
		FUEL_FLOW_UOM,
		FUEL_FLOW_SODC,
		SULFUR_CONTENT,
		SULFUR_UOM,
		SULFUR_SAMPLING_TYPE,
		DEFAULT_SO2_EMISSION_RATE,
		CALC_HI_RATE,
		FORMULA_CD,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		SUMMATION_FORMULA_CD,
		RPT_SO2_MASS_RATE_ALL_FUELS,
		CALC_SO2_MASS_RATE_ALL_FUELS,
		ERROR_CODES
	)
	SELECT DISTINCT
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
		CASE WHEN (MF.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (FC.FUEL_GROUP_CD = 'GAS') THEN HFF.CALC_VOLUMETRIC_FLOW_RATE
				ELSE HFF.CALC_MASS_FLOW_RATE
			END 
		END AS CALC_FUEL_FLOW,
		CASE WHEN (MF.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (FC.FUEL_GROUP_CD = 'GAS') THEN HFF.VOLUMETRIC_UOM_CD
				ELSE 'LBHR'
			END
		END AS FUEL_FLOW_UOM,
		CASE WHEN (MF.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (FC.FUEL_GROUP_CD = 'GAS') THEN HFF.SOD_VOLUMETRIC_CD
				ELSE HFF.SOD_MASS_CD
			END
		END AS FUEL_FLOW_SODC,
		HPFF.sulfur_PARAM_VAL_FUEL AS SULFUR_CONTENT,
		HPFF.sulfur_PARAMETER_UOM_CD AS SULFUR_UOM,
		HPFF.sulfur_SAMPLE_TYPE_CD AS SULFUR_SAMPLING_TYPE,
		HPFF.SO2R_PARAM_VAL_FUEL AS DEFAULT_SO2_EMISSION_RATE,
		HPFF.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		MF.EQUATION_CD AS FORMULA_CD,
		HPFF.so2_PARAM_VAL_FUEL AS RPT_SO2_MASS_RATE,
		HPFF.so2_CALC_PARAM_VAL_FUEL AS CALC_SO2_MASS_RATE,
		SUMMATION_MF.EQUATION_CD AS SUMMATION_FORMULA_CD,
		DHV.SO2_ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS_RATE_ALL_FUELS,
		DHV.SO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS_RATE_ALL_FUELS,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	INNER JOIN camdecmpswks.HRLY_FUEL_FLOW HFF 
		ON HOD.HOUR_ID = HFF.HOUR_ID
	JOIN camdecmpswks.get_hourly_param_fuel_flow_pivoted(
		vmonplanid, vrptperiodid, hpffParamCodes
	) AS hpff (
		hrly_fuel_flow_id character varying,
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		so2_hour_id character varying,
		so2_mon_sys_id character varying,
		so2_mon_form_id character varying,
		so2_param_val_fuel numeric,
		so2_calc_param_val_fuel numeric,
		so2_segment_num numeric,
		so2_sample_type_cd character varying,
		so2_parameter_uom_cd character varying,
		so2_operating_condition_cd character varying,
		sulfur_hour_id character varying,
		sulfur_mon_sys_id character varying,
		sulfur_mon_form_id character varying,
		sulfur_param_val_fuel numeric,
		sulfur_calc_param_val_fuel numeric,
		sulfur_segment_num numeric,
		sulfur_sample_type_cd character varying,
		sulfur_parameter_uom_cd character varying,
		sulfur_operating_condition_cd character varying,
		so2r_hour_id character varying,
		so2r_mon_sys_id character varying,
		so2r_mon_form_id character varying,
		so2r_param_val_fuel numeric,
		so2r_calc_param_val_fuel numeric,
		so2r_segment_num numeric,
		so2r_sample_type_cd character varying,
		so2r_parameter_uom_cd character varying,
		so2r_operating_condition_cd character varying,
		hi_hour_id character varying,
		hi_mon_sys_id character varying,
		hi_mon_form_id character varying,
		hi_param_val_fuel numeric,
		hi_calc_param_val_fuel numeric,
		hi_segment_num numeric,
		hi_sample_type_cd character varying,
		hi_parameter_uom_cd character varying,
		hi_operating_condition_cd character varying
	) 
		ON hpff.HOUR_ID = hod.HOUR_ID
		AND hpff.MON_LOC_ID = hod.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmpswks.MONITOR_SYSTEM MS 
		ON HFF.MON_SYS_ID = MS.MON_SYS_ID
	LEFT JOIN camdecmpswks.get_derived_hourly_values_pivoted(
		vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
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
		so2_modc_cd character varying) 
	ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA AS MF 
		ON HPFF.so2_MON_FORM_ID = MF.MON_FORM_ID
	LEFT OUTER JOIN camdecmpswks.MONITOR_FORMULA AS SUMMATION_MF 
		ON DHV.so2_MON_FORM_ID = SUMMATION_MF.MON_FORM_ID
	LEFT OUTER JOIN camdecmpsmd.FUEL_CODE FC 
		ON FC.FUEL_CD = HFF.FUEL_CD
WHERE hpff.so2_hour_id is not null;

  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SO2APPD');
END
$procedure$
