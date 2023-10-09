DROP FUNCTION IF EXISTS camdecmps.get_monitor_hourly_values(character varying);

CREATE OR REPLACE FUNCTION camdecmps.get_monitor_hourly_values(
	vparametercd character varying
)
RETURNS TABLE(
	HOUR_ID character varying,
	RPT_PERIOD_ID numeric,
	MON_LOC_ID character varying,
	MON_SYS_ID character varying,
	COMPONENT_ID character varying,
	PARAMETER_CD character varying,
	MODC_CD character varying,
	MOISTURE_BASIS character varying,
	ADJUSTED_HRLY_VALUE numeric,
	UNADJUSTED_HRLY_VALUE numeric,
	CALC_ADJUSTED_HRLY_VALUE numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT
		hod.HOUR_ID,
		mhv.RPT_PERIOD_ID,
		mhv.MON_LOC_ID,
		mhv.MON_SYS_ID,
		mhv.COMPONENT_ID,
		mhv.PARAMETER_CD,
		mhv.MODC_CD,
		mhv.MOISTURE_BASIS,
		mhv.ADJUSTED_HRLY_VALUE,
		mhv.UNADJUSTED_HRLY_VALUE,
		mhv.CALC_ADJUSTED_HRLY_VALUE
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.MONITOR_HRLY_VALUE mhv
		ON hod.HOUR_ID = mhv.HOUR_ID
		AND hod.MON_LOC_ID = mhv.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = mhv.RPT_PERIOD_ID    
		AND mhv.PARAMETER_CD = vparametercd;
END
$BODY$;
