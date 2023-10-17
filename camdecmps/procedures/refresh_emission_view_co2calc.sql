DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_co2calc(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_co2calc(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  stopTime time without time zone;
  startTime time without time zone := CURRENT_TIME;
BEGIN
  RAISE NOTICE 'Refresh started @ % %', CURRENT_DATE, startTime;

  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_CO2CALC
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_CO2CALC(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		CO2C_MODC,
		CO2C_PMA,
		RPT_PCT_O2,
		PCT_O2_USED,
		O2_MODC,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		FC_FACTOR,
		FD_FACTOR,
		FORMULA_CD,
		RPT_PCT_CO2,
		CALC_PCT_CO2,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME,	
		dhv.MODC_CD AS CO2C_MODC,
		dhv.PCT_AVAILABLE AS CO2C_PMA,
		CASE (mf.EQUATION_CD)
			WHEN 'F-14A' THEN mhv_DRY.UNADJUSTED_HRLY_VALUE
			WHEN 'F-14B' THEN mhv_WET.UNADJUSTED_HRLY_VALUE
		END AS RPT_PCT_O2,
		dhv.CALC_PCT_DILUENT AS PCT_O2_USED,
		CASE (mf.EQUATION_CD)
			WHEN 'F-14A' THEN mhv_DRY.MODC_CD
			WHEN 'F-14B' THEN mhv_WET.MODC_CD
		END AS O2_MODC,
		dhv.CALC_PCT_MOISTURE AS PCT_H2O_USED,
		CASE 
			WHEN (dhv.CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (dhv_H2O.HOUR_ID IS NOT NULL) THEN dhv_H2O.MODC_CD 
					WHEN (mhv_H2O.HOUR_ID IS NOT NULL) THEN mhv_H2O.MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		hod.FC_FACTOR AS FC_FACTOR,
		hod.FD_FACTOR AS FD_FACTOR,
		mf.EQUATION_CD AS FORMULA_CD,
		dhv.ADJUSTED_HRLY_VALUE AS RPT_PCT_CO2,
		dhv.CALC_ADJUSTED_HRLY_VALUE AS CALC_PCT_CO2,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.DERIVED_HRLY_VALUE AS dhv
		ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND dhv.PARAMETER_CD = 'CO2C'
	LEFT JOIN camdecmps.MONITOR_FORMULA AS mf
		ON dhv.MON_FORM_ID = mf.MON_FORM_ID
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			ADJUSTED_HRLY_VALUE, UNADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmps.MONITOR_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'H2O'
	) AS mhv_H2O 
		ON mhv_H2O.HOUR_ID = dhv.HOUR_ID
		AND mhv_H2O.MON_LOC_ID = dhv.MON_LOC_ID
		AND mhv_H2O.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			MON_FORM_ID, ADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmps.DERIVED_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'H2O'
	) AS dhv_H2O
		ON dhv_H2O.HOUR_ID = dhv.HOUR_ID
		AND dhv_H2O.MON_LOC_ID = dhv.MON_LOC_ID
		AND dhv_H2O.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_DEFAULT AS md_H2O 
		ON md_H2O.MON_LOC_ID = dhv_H2O.MON_LOC_ID
		AND md_H2O.DEFAULT_PURPOSE_CD = 'PM'
		AND md_H2O.PARAMETER_CD = 'H2O'
		AND camdecmps.emissions_monitor_default_active(md_H2O.BEGIN_DATE, md_H2O.BEGIN_HOUR, md_H2O.END_DATE, md_H2O.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			ADJUSTED_HRLY_VALUE, UNADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmps.MONITOR_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'O2C' AND MOISTURE_BASIS = 'D'
	) AS mhv_DRY 
		ON mhv_DRY.HOUR_ID = dhv.HOUR_ID
		AND mhv_DRY.MON_LOC_ID = dhv.MON_LOC_ID
		AND mhv_DRY.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, MODC_CD,
			ADJUSTED_HRLY_VALUE, UNADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmps.MONITOR_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'O2C' AND MOISTURE_BASIS = 'W'
	) AS mhv_WET 
		ON mhv_WET.HOUR_ID = dhv.HOUR_ID
		AND mhv_WET.MON_LOC_ID = dhv.MON_LOC_ID
		AND mhv_WET.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2CALC');

  stopTime := CURRENT_TIME;
  RAISE NOTICE 'Refresh complete @ % %, total time: %', CURRENT_DATE, stopTime, stopTime - startTime;
END
$BODY$;

/*
----------------------------------------------------------------------------------------
FOR TESTING PURPOSES ONLY
----------------------------------------------------------------------------------------
DROP TABLE temp_hourly_test_errors;
CALL camdecmps.load_temp_hourly_test_errors('FPEARSON-P-718AA19AD70646A8A9C24BB36FE304C5', 120);
select * from temp_hourly_test_errors

select a.mon_plan_id, *
from camdecmps.monitor_plan_location a
JOIN camdecmps.DERIVED_HRLY_VALUE AS dhv
	ON a.MON_LOC_ID = dhv.MON_LOC_ID
	AND dhv.RPT_PERIOD_ID = 120
	AND dhv.PARAMETER_CD = 'CO2C'
order by a.mon_loc_id
*/
