DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_co2appd(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_co2appd(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmpswks.EMISSION_VIEW_CO2APPD 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmpswks.EMISSION_VIEW_CO2APPD(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		FUEL_TYPE,
		FUEL_USE_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		CALC_HI_RATE,
		FC_FACTOR,
		FORMULA_CD,
		RPT_CO2_MASS_RATE,
		CALC_CO2_MASS_RATE,
		SUMMATION_FORMULA_CD,
		RPT_CO2_MASS_RATE_ALL_FUELS,
		CALC_CO2_MASS_RATE_ALL_FUELS,
		ERROR_CODES
	)
	SELECT 
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null), 
		hod.OP_TIME,
		COALESCE(ms.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		hff.FUEL_CD AS FUEL_TYPE,
		hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		hpff_HI.CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
		hpff_FC.PARAM_VAL_FUEL AS FC_FACTOR,
		mf_hpff_CO2.EQUATION_CD AS FORMULA_CD,
		hpff_CO2.PARAM_VAL_FUEL AS RPT_CO2_MASS_RATE,
		hpff_CO2.CALC_PARAM_VAL_FUEL AS CALC_CO2_MASS_RATE,
		mf_dhv_CO2.EQUATION_CD AS SUMMATION_FORMULA_CD,
		dhv_CO2.ADJUSTED_HRLY_VALUE AS RPT_CO2_MASS_RATE_ALL_FUELS,
		dhv_CO2.CALC_ADJUSTED_HRLY_VALUE AS CALC_CO2_MASS_RATE_ALL_FUELS,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.HRLY_FUEL_FLOW hff
		ON hff.HOUR_ID = hod.HOUR_ID
		AND hff.MON_LOC_ID = hod.MON_LOC_ID
		AND hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_SYSTEM AS ms
		ON ms.MON_SYS_ID = hff.MON_SYS_ID
	LEFT JOIN (
		SELECT
			HOUR_ID, MON_LOC_ID, RPT_PERIOD_ID, PARAMETER_CD,
			MON_FORM_ID, ADJUSTED_HRLY_VALUE, CALC_ADJUSTED_HRLY_VALUE
		FROM camdecmpswks.DERIVED_HRLY_VALUE
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'CO2'
	) AS dhv_CO2
		ON dhv_CO2.HOUR_ID = hod.HOUR_ID
		AND dhv_CO2.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv_CO2.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_dhv_CO2
		ON mf_dhv_CO2.MON_FORM_ID = dhv_CO2.MON_FORM_ID
	LEFT JOIN (
		SELECT
			HRLY_FUEL_FLOW_ID, MON_LOC_ID, RPT_PERIOD_ID,
			MON_FORM_ID, PARAM_VAL_FUEL, CALC_PARAM_VAL_FUEL
		FROM camdecmpswks.HRLY_PARAM_FUEL_FLOW
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'CO2'
	) AS hpff_CO2
		ON hpff_CO2.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff_CO2.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff_CO2.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA mf_hpff_CO2
		ON mf_hpff_CO2.MON_FORM_ID = hpff_CO2.MON_FORM_ID
	LEFT JOIN (
		SELECT
			HRLY_FUEL_FLOW_ID, MON_LOC_ID, RPT_PERIOD_ID,
			MON_FORM_ID, PARAM_VAL_FUEL, CALC_PARAM_VAL_FUEL
		FROM camdecmpswks.HRLY_PARAM_FUEL_FLOW
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'HI'
	) AS hpff_HI
		ON hpff_HI.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff_HI.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff_HI.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN (
		SELECT
			HRLY_FUEL_FLOW_ID, MON_LOC_ID, RPT_PERIOD_ID,
			MON_FORM_ID, PARAM_VAL_FUEL, CALC_PARAM_VAL_FUEL
		FROM camdecmpswks.HRLY_PARAM_FUEL_FLOW
		WHERE RPT_PERIOD_ID = vrptperiodid AND PARAMETER_CD = 'FC'
	) AS hpff_FC
		ON hpff_FC.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff_FC.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff_FC.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	WHERE hpff_CO2.HRLY_FUEL_FLOW_ID IS NOT NULL OR (
		hpff_CO2.HRLY_FUEL_FLOW_ID IS NULL AND (
			hpff_HI.HRLY_FUEL_FLOW_ID IS NOT NULL AND dhv_CO2.PARAMETER_CD IS NOT NULL
		)
	);

  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2APPD');
END
$BODY$;

/*
----------------------------------------------------------------------------------------
FOR TESTING PURPOSES ONLY
----------------------------------------------------------------------------------------
DROP TABLE temp_hourly_test_errors;
CALL camdecmpswks.load_temp_hourly_test_errors('TWCORNEL5-C0E3879920A14159BAA98E03F1980A7A', 120);
select * from temp_hourly_test_errors

select a.mon_plan_id, *
from camdecmpswks.monitor_plan_location a
--TRIED TO WRITE THIS BUT NOTHING PERFORMS GOOD BUT THE MP/RPT PERIOD ABOVE HAS DATA
order by a.mon_loc_id
*/