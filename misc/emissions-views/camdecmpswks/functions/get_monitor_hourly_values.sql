DROP FUNCTION IF EXISTS camdecmpswks.get_monitor_hourly_values(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.get_monitor_hourly_values(
	vparametercd character varying
) RETURNS TABLE(HOUR_ID character varying, PARAMETER_CD character varying, ADJUSTED_HRLY_VALUE numeric, UNADJUSTED_HRLY_VALUE numeric, CALC_ADJUSTED_HRLY_VALUE numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RETURN QUERY
	SELECT
		hod.HOUR_ID,
		mhv.PARAMETER_CD,
		mhv.ADJUSTED_HRLY_VALUE,
		mhv.UNADJUSTED_HRLY_VALUE,
		mhv.CALC_ADJUSTED_HRLY_VALUE
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.MONITOR_HRLY_VALUE mhv
		ON hod.HOUR_ID = mhv.HOUR_ID
		AND hod.MON_LOC_ID = mhv.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = mhv.RPT_PERIOD_ID    
    AND mhv.PARAMETER_CD = vparametercd;
END
$BODY$;