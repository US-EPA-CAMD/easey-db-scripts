DROP FUNCTION IF EXISTS camdecmps.get_hourly_param_fuel_flows(character varying);

CREATE OR REPLACE FUNCTION camdecmps.get_hourly_param_fuel_flows(
	vparametercd character varying
)
RETURNS TABLE(
	HOUR_ID character varying,
	HRLY_FUEL_FLOW_ID character varying,
	RPT_PERIOD_ID numeric,
	MON_LOC_ID character varying,
	MON_SYS_ID character varying,
	MON_FORM_ID character varying,
	PARAMETER_CD character varying,
	PARAM_VAL_FUEL numeric,
	CALC_PARAM_VAL_FUEL numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN QUERY
	SELECT
		hff.HOUR_ID,
		hff.HRLY_FUEL_FLOW_ID,
		hff.RPT_PERIOD_ID,
		hff.MON_LOC_ID,
		hpff.MON_SYS_ID,
		hpff.MON_FORM_ID,
		hpff.PARAMETER_CD,
		hpff.PARAM_VAL_FUEL,
		hpff.CALC_PARAM_VAL_FUEL
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.HRLY_FUEL_FLOW hff
		ON hod.HOUR_ID = hff.HOUR_ID
		AND hod.MON_LOC_ID = hff.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	JOIN camdecmps.HRLY_PARAM_FUEL_FLOW hpff
		ON hff.HRLY_FUEL_FLOW_ID = hpff.HRLY_FUEL_FLOW_ID
		AND hod.MON_LOC_ID = hff.MON_LOC_ID
		AND hod.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
		AND hpff.PARAMETER_CD = vparametercd;
END
$BODY$;
