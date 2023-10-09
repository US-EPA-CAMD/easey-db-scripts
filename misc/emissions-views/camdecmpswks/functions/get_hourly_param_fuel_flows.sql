DROP FUNCTION IF EXISTS camdecmpswks.get_hourly_param_fuel_flows(character varying);

CREATE OR REPLACE FUNCTION camdecmpswks.get_hourly_param_fuel_flows(
	vparametercd text
) RETURNS TABLE(HOUR_ID character varying, HRLY_FUEL_FLOW_ID character varying, MON_LOC_ID character varying, EQUATION_CD character varying, PARAM_VAL_FUEL numeric, CALC_PARAM_VAL_FUEL numeric)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  RETURN QUERY
	SELECT
		hff.HOUR_ID,
		hff.HRLY_FUEL_FLOW_ID,
		hff.MON_LOC_ID,
		mf.EQUATION_CD,
		hpff.PARAM_VAL_FUEL,
		hpff.CALC_PARAM_VAL_FUEL
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.HRLY_FUEL_FLOW hff
		ON hod.HOUR_ID = hff.HOUR_ID
		AND hod.MON_LOC_ID = hff.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	JOIN camdecmpswks.HRLY_PARAM_FUEL_FLOW hpff
		ON hff.HRLY_FUEL_FLOW_ID = hpff.HRLY_FUEL_FLOW_ID
		AND hod.MON_LOC_ID = hff.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
		AND hpff.PARAMETER_CD = vparametercd
	LEFT JOIN camdecmpswks.MONITOR_FORMULA MF
		ON hpff.MON_FORM_ID = MF.MON_FORM_ID
	ORDER BY MON_LOC_ID;
END
$BODY$;
