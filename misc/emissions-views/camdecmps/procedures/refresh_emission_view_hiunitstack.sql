-- PROCEDURE: camdecmps.refresh_emission_view_hiunitstack()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_hiunitstack();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_hiunitstack()
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE camdecmps.EMISSION_VIEW_HIUNITSTACK RESTART IDENTITY;

	INSERT INTO camdecmps.EMISSION_VIEW_HIUNITSTACK(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		HI_FORMULA_CD,
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
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		HOD.LOAD_RANGE, 
		HOD.COMMON_STACK_LOAD_RANGE, 
		MF.EQUATION_CD AS HI_FORMULA_CD, 
		DHV.ADJUSTED_HRLY_VALUE AS RPT_HI_RATE, 
		DHV.CALC_ADJUSTED_HRLY_VALUE AS CALC_HI_RATE, 
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD
	INNER JOIN camdecmps.DERIVED_HRLY_VALUE AS DHV 
		ON HOD.HOUR_ID = DHV.HOUR_ID AND DHV.PARAMETER_CD = 'HI'
	LEFT OUTER JOIN camdecmps.MONITOR_HRLY_VALUE AS MHV 
		ON HOD.HOUR_ID = MHV.HOUR_ID AND MHV.PARAMETER_CD = 'FLOW' 
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS MF 
		ON DHV.MON_FORM_ID = MF.MON_FORM_ID
	WHERE MHV.PARAMETER_CD IS NULL;
END
$BODY$;