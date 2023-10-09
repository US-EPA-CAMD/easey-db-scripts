DROP FUNCTION IF EXISTS camdecmpswks.get_derived_hourly_values(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.get_derived_hourly_values(
	vparametercd character varying
) RETURNS TABLE(HOUR_ID character varying, EQUATION_CD character varying, PARAMETER_CD character varying, ADJUSTED_HRLY_VALUE numeric, CALC_ADJUSTED_HRLY_VALUE numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT
		hod.HOUR_ID,
		mf.EQUATION_CD,
		dhv.PARAMETER_CD,
		dhv.ADJUSTED_HRLY_VALUE,
		dhv.CALC_ADJUSTED_HRLY_VALUE
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.DERIVED_HRLY_VALUE dhv
		ON hod.HOUR_ID = dhv.HOUR_ID
		AND hod.MON_LOC_ID = dhv.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = dhv.RPT_PERIOD_ID    
    AND dhv.PARAMETER_CD = vparametercd
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf
		ON dhv.MON_FORM_ID = mf.MON_FORM_ID;
END
$BODY$;