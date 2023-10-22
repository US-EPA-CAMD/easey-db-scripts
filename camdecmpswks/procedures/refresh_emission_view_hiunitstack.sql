DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_hiunitstack(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiunitstack(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_HIUNITSTACK
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_HIUNITSTACK(
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
	SELECT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
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
	JOIN camdecmpswks.DERIVED_HRLY_VALUE AS DHV 
		ON HOD.HOUR_ID = DHV.HOUR_ID
		AND HOD.MON_LOC_ID = DHV.MON_LOC_ID
		AND HOD.RPT_PERIOD_ID = DHV.RPT_PERIOD_ID		
		AND DHV.PARAMETER_CD = 'HI'
	LEFT JOIN camdecmpswks.MONITOR_FORMULA AS MF 
		ON DHV.MON_FORM_ID = MF.MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_HRLY_VALUE AS MHV 
		ON HOD.HOUR_ID = MHV.HOUR_ID
		AND HOD.MON_LOC_ID = MHV.MON_LOC_ID
		AND HOD.RPT_PERIOD_ID = MHV.RPT_PERIOD_ID		
		AND MHV.PARAMETER_CD = 'FLOW'
  WHERE MHV.PARAMETER_CD IS NULL;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIUNITSTACK');
END
$BODY$;
