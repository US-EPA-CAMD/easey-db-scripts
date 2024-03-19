-- PROCEDURE: camdecmps.refresh_emission_view_so2appd(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_so2appd(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_so2appd(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['SO2'];
  hpffParamCodes text[] :=   ARRAY['SO2','SULFUR','SO2R','HI'];
BEGIN
	RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_SO2APPD 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_SO2APPD(
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
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME,
		COALESCE(ms.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		hff.FUEL_CD AS FUEL_TYPE,
		hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		CASE WHEN (mf.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (fc.FUEL_GROUP_CD = 'GAS') THEN hff.CALC_VOLUMETRIC_FLOW_RATE
				ELSE hff.CALC_MASS_FLOW_RATE
			END 
		END AS CALC_FUEL_FLOW,
		CASE WHEN (mf.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (fc.FUEL_GROUP_CD = 'GAS') THEN hff.VOLUMETRIC_UOM_CD
				ELSE 'LBHR'
			END
		END AS FUEL_FLOW_UOM,
		CASE WHEN (mf.EQUATION_CD IN ('D-2', 'D-4')) THEN
			CASE 
				WHEN (fc.FUEL_GROUP_CD = 'GAS') THEN hff.SOD_VOLUMETRIC_CD
				ELSE hff.SOD_MASS_CD
			END
		END AS FUEL_FLOW_SODC,
		hpff.SULFUR_PARAM_VAL_FUEL AS SULFUR_CONTENT,
		hpff.SULFUR_PARAMETER_UOM_CD AS SULFUR_UOM,
		hpff.SULFUR_SAMPLE_TYPE_CD AS SULFUR_SAMPLING_TYPE,
		hpff.SO2R_PARAM_VAL_FUEL AS DEFAULT_SO2_EMISSION_RATE,
		hpff.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		mf.EQUATION_CD AS FORMULA_CD,
		hpff.SO2_PARAM_VAL_FUEL AS RPT_SO2_MASS_RATE,
		hpff.SO2_CALC_PARAM_VAL_FUEL AS CALC_SO2_MASS_RATE,
		mf_SUMMATION.EQUATION_CD AS SUMMATION_FORMULA_CD,
		dhv.SO2_ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS_RATE_ALL_FUELS,
		dhv.SO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS_RATE_ALL_FUELS,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	INNER JOIN camdecmps.HRLY_FUEL_FLOW hff 
		ON hod.HOUR_ID = hff.HOUR_ID
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
		so2_modc_cd character varying
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
        so2_hrly_fuel_flow_id character varying,
        so2_mon_form_id character varying,
        so2_param_val_fuel numeric,
        so2_calc_param_val_fuel numeric,
        so2_segment_num numeric,
        so2_sample_type_cd character varying,
        so2_parameter_uom_cd character varying,
        so2_operating_condition_cd character varying,
		sulfur_hrly_fuel_flow_id character varying,
        sulfur_mon_form_id character varying,
        sulfur_param_val_fuel numeric,
        sulfur_calc_param_val_fuel numeric,
        sulfur_segment_num numeric,
        sulfur_sample_type_cd character varying,
        sulfur_parameter_uom_cd character varying,
        sulfur_operating_condition_cd character varying,
		so2r_hrly_fuel_flow_id character varying,
        so2r_mon_form_id character varying,
        so2r_param_val_fuel numeric,
        so2r_calc_param_val_fuel numeric,
        so2r_segment_num numeric,
        so2r_sample_type_cd character varying,
        so2r_parameter_uom_cd character varying,
        so2r_operating_condition_cd character varying,
		hi_hrly_fuel_flow_id character varying,
        hi_mon_form_id character varying,
        hi_param_val_fuel numeric,
        hi_calc_param_val_fuel numeric,
        hi_segment_num numeric,
        hi_sample_type_cd character varying,
        hi_parameter_uom_cd character varying,
        hi_operating_condition_cd character varying
	) ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff.HOUR_ID = hff.HOUR_ID
		AND hpff.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.MONITOR_SYSTEM ms 
		ON hff.MON_SYS_ID = ms.MON_SYS_ID
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS mf 
		ON hpff_SO2.MON_FORM_ID = mf.MON_FORM_ID
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS mf_SUMMATION 
		ON dhv_SO2.MON_FORM_ID = mf_SUMMATION.MON_FORM_ID
	LEFT OUTER JOIN camdecmpsmd.FUEL_CODE fc 
		ON fc.FUEL_CD = hff.FUEL_CD;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SO2APPD');
END
$BODY$;
