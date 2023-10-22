DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_moisture(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_moisture(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_MOISTURE
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MOISTURE(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		H2O_MODC,
		H2O_PMA,
		PCT_O2_WET,
		O2_WET_MODC,
		PCT_O2_DRY,
		O2_DRY_MODC,
		H2O_FORMULA_CD,
		RPT_PCT_H2O,
		CALC_PCT_H2O,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME, 
		dhv.MODC_CD AS H2O_MODC,
		dhv.PCT_AVAILABLE AS H2O_PMA,
		mhv_WET.UNADJUSTED_HRLY_VALUE AS PCT_O2_WET,
		mhv_WET.MODC_CD AS O2_WET_MODC,
		mhv_DRY.UNADJUSTED_HRLY_VALUE AS PCT_O2_DRY,
		mhv_DRY.MODC_CD AS O2_DRY_MODC,
		mf.EQUATION_CD AS H2O_FORMULA_CD,
		dhv.ADJUSTED_HRLY_VALUE AS RPT_PCT_H2O,
		dhv.CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_H2O,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.DERIVED_HRLY_VALUE AS dhv 
		ON dhv.HOUR_ID = HOD.HOUR_ID
		AND dhv.MON_LOC_ID = HOD.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = HOD.RPT_PERIOD_ID
		AND dhv.PARAMETER_CD = 'H2O'
		AND dhv.MODC_CD <> '40'
	LEFT JOIN camdecmpswks.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = dhv.MON_FORM_ID 
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			ADJUSTED_HRLY_VALUE, UNADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmpswks.MONITOR_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'O2C' AND MOISTURE_BASIS = 'W'
	) AS mhv_WET 
		ON mhv_WET.HOUR_ID = dhv.HOUR_ID
		AND mhv_WET.MON_LOC_ID = dhv.MON_LOC_ID
		AND mhv_WET.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			ADJUSTED_HRLY_VALUE, UNADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmpswks.MONITOR_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'O2C' AND MOISTURE_BASIS = 'D'
	) AS mhv_DRY 
		ON mhv_DRY.HOUR_ID = dhv.HOUR_ID
		AND mhv_DRY.MON_LOC_ID = dhv.MON_LOC_ID
		AND mhv_DRY.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MOISTURE');
END
$BODY$;

/*
----------------------------------------------------------------------------------------
FOR TESTING PURPOSES ONLY
----------------------------------------------------------------------------------------
DROP TABLE temp_hourly_test_errors;
DROP TABLE temp_hourly_test_errors;
CALL camdecmpswks.load_temp_hourly_test_errors('TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120);
CALL camdecmpswks.load_temp_hourly_test_errors('MDC-C7BDBE7919DC439884869654E6F3B19B', 120);

select a.mon_plan_id, *
from camdecmpswks.monitor_plan_location a
JOIN camdecmpswks.DERIVED_HRLY_VALUE AS DHV 
	ON a.MON_LOC_ID = DHV.MON_LOC_ID
	AND DHV.RPT_PERIOD_ID = 120	
	AND DHV.PARAMETER_CD = 'H2O'
	AND DHV.MODC_CD <> '40'
order by a.mon_loc_id
*/