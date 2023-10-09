DROP FUNCTION IF EXISTS camdecmps.get_derived_hourly_values(character varying);

CREATE OR REPLACE FUNCTION camdecmps.get_derived_hourly_values(
	vparametercd character varying
)
RETURNS TABLE(
	HOUR_ID character varying,
	RPT_PERIOD_ID numeric,
	MON_LOC_ID character varying,
	MON_SYS_ID character varying,
	MON_FORM_ID character varying,
	PARAMETER_CD character varying,
	MODC_CD character varying,
	PCT_AVAILABLE numeric,
	CALC_PCT_DILUENT numeric,
	CALC_PCT_MOISTURE numeric,
	ADJUSTED_HRLY_VALUE numeric,
	CALC_ADJUSTED_HRLY_VALUE numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT
		hod.HOUR_ID,
		dhv.RPT_PERIOD_ID,
		dhv.MON_LOC_ID,
		dhv.MON_SYS_ID,
		dhv.MON_FORM_ID,
		dhv.PARAMETER_CD,
		dhv.MODC_CD,
		dhv.PCT_AVAILABLE,
		dhv.CALC_PCT_DILUENT,
		dhv.CALC_PCT_MOISTURE,
		dhv.ADJUSTED_HRLY_VALUE,
		dhv.CALC_ADJUSTED_HRLY_VALUE
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.DERIVED_HRLY_VALUE dhv
		ON hod.HOUR_ID = dhv.HOUR_ID
		AND hod.MON_LOC_ID = dhv.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID
		AND dhv.PARAMETER_CD = vparametercd;
END
$BODY$;
