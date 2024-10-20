-- PROCEDURE: camdecmps.refresh_emission_view_hiappd()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_hiappd();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_hiappd()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE camdecmps.EMISSION_VIEW_HIAPPD RESTART IDENTITY;

	INSERT INTO camdecmps.EMISSION_VIEW_HIAPPD(
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
		RPT_FUEL_FLOW,
		CALC_FUEL_FLOW,
		FUEL_FLOW_UOM,
		FUEL_FLOW_SODC,
		GROSS_CALORIFIC_VALUE,
		GCV_UOM,
		GCV_SAMPLING_TYPE,
		FORMULA_CD,
		RPT_HI_RATE,
		CALC_HI_RATE,
		ERROR_CODES
	)
	SELECT DISTINCT 
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		HOD.OP_TIME,
		COALESCE(MS.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		HFF.FUEL_CD AS FUEL_TYPE,
		HFF.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		CASE 
			WHEN ((FC.FUEL_GROUP_CD = 'GAS') OR (MF.EQUATION_CD = 'F-19V')) THEN HFF.VOLUMETRIC_FLOW_RATE
			ELSE HFF.MASS_FLOW_RATE
		END AS RPT_FUEL_FLOW,
		CASE 
			WHEN ((FC.FUEL_GROUP_CD = 'GAS') OR (MF.EQUATION_CD = 'F-19V')) THEN HFF.CALC_VOLUMETRIC_FLOW_RATE
			ELSE HFF.CALC_MASS_FLOW_RATE
		END AS CALC_FUEL_FLOW,
		CASE 
			WHEN ((FC.FUEL_GROUP_CD = 'GAS') OR (MF.EQUATION_CD = 'F-19V')) THEN HFF.VOLUMETRIC_UOM_CD
			ELSE 'LBHR'
		END AS FUEL_FLOW_UOM,
		CASE 
			WHEN ((FC.FUEL_GROUP_CD = 'GAS') OR (MF.EQUATION_CD = 'F-19V')) THEN HFF.SOD_VOLUMETRIC_CD
			ELSE HFF.SOD_MASS_CD
		END AS FUEL_FLOW_SODC,
		HPFF_GCV.PARAM_VAL_FUEL AS GROSS_CALORIFIC_VALUE,
		HPFF_GCV.PARAMETER_UOM_CD AS GCV_UOM,
		HPFF_GCV.SAMPLE_TYPE_CD AS GCV_SAMPLING_TYPE,
		MF.EQUATION_CD AS FORMULA_CD,
		HPFF_HI.PARAM_VAL_FUEL AS RPT_HI_RATE,
		HPFF_HI.CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD
	INNER JOIN camdecmps.HRLY_FUEL_FLOW HFF 
		ON HOD.HOUR_ID = HFF.HOUR_ID
	INNER JOIN camdecmps.HRLY_PARAM_FUEL_FLOW HPFF_HI 
		ON HFF.HRLY_FUEL_FLOW_ID = HPFF_HI.HRLY_FUEL_FLOW_ID AND HPFF_HI.PARAMETER_CD = 'HI'
	LEFT OUTER JOIN camdecmps.HRLY_PARAM_FUEL_FLOW HPFF_GCV 
		ON HFF.HRLY_FUEL_FLOW_ID = HPFF_GCV.HRLY_FUEL_FLOW_ID AND HPFF_GCV.PARAMETER_CD = 'GCV'
	LEFT OUTER JOIN camdecmps.MONITOR_SYSTEM MS 
		ON HFF.MON_SYS_ID = MS.MON_SYS_ID
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS MF 
		ON HPFF_HI.MON_FORM_ID = MF.MON_FORM_ID
	LEFT OUTER JOIN camdecmpsmd.FUEL_CODE FC 
		ON HFF.FUEL_CD = FC.FUEL_CD;
END
$BODY$;
