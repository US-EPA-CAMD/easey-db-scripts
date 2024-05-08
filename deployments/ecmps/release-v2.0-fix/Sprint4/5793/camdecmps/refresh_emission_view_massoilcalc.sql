CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_massoilcalc(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    hpffParamCodes text[] := ARRAY['DENSOIL'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_MASSOILCALC
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_MASSOILCALC(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		FUEL_SYS_ID,
		OIL_TYPE,
		FUEL_USE_TIME,
		RPT_VOLUMETRIC_OIL_FLOW,
		CALC_VOLUMETRIC_OIL_FLOW,
		VOLUMETRIC_OIL_FLOW_UOM,
		VOLUMETRIC_OIL_FLOW_SODC,
		OIL_DENSITY,
		OIL_DENSITY_UOM,
		OIL_DENSITY_SAMPLING_TYPE,
		RPT_MASS_OIL_FLOW,
		CALC_MASS_OIL_FLOW,
		ERROR_CODES
	)
	SELECT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		HOD.OP_TIME,
		COALESCE(MS.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
		HFF.FUEL_CD AS OIL_TYPE,
		HFF.FUEL_USAGE_TIME AS FUEL_USE_TIME,
		HFF.VOLUMETRIC_FLOW_RATE AS RPT_VOLUMETRIC_OIL_FLOW,
		HFF.CALC_VOLUMETRIC_FLOW_RATE AS CALC_VOLUMETRIC_OIL_FLOW,
		HFF.VOLUMETRIC_UOM_CD AS VOLUMETRIC_OIL_FLOW_UOM,
		HFF.SOD_VOLUMETRIC_CD AS VOLUMETRIC_OIL_FLOW_SODC,
		HPFF.DENSOIL_PARAM_VAL_FUEL AS OIL_DENSITY,
		HPFF.DENSOIL_PARAMETER_UOM_CD AS OIL_DENSITY_UOM,
		HPFF.DENSOIL_SAMPLE_TYPE_CD AS OIL_DENSITY_SAMPLING_TYPE,
		HFF.MASS_FLOW_RATE AS RPT_MASS_OIL_FLOW,
		HFF.CALC_MASS_FLOW_RATE AS CALC_MASS_OIL_FLOW,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	JOIN camdecmps.HRLY_FUEL_FLOW HFF 
		ON HOD.HOUR_ID = HFF.HOUR_ID
		AND HOD.MON_LOC_ID = HFF.MON_LOC_ID
		AND HOD.RPT_PERIOD_ID = HFF.RPT_PERIOD_ID
	JOIN camdecmps.get_hourly_param_fuel_flow_pivoted(
	  vmonplanid, vrptperiodid, hpffParamCodes
	) AS hpff (
		hrly_fuel_flow_id character varying,
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		densoil_hrly_fuel_flow_id character varying,
		densoil_mon_sys_id character varying,
		densoil_mon_form_id character varying,
		densoil_param_val_fuel numeric,
		densoil_calc_param_val_fuel numeric,
		densoil_segment_num numeric,
		densoil_sample_type_cd character varying,
		densoil_parameter_uom_cd character varying,
		densoil_operating_condition_cd character varying
	)   ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
		AND hpff.HOUR_ID = hff.HOUR_ID
		AND hpff.MON_LOC_ID = hff.MON_LOC_ID
		AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_SYSTEM MS 
		ON HFF.MON_SYS_ID = MS.MON_SYS_ID
	WHERE HFF.VOLUMETRIC_FLOW_RATE > 0 
		AND HFF.MASS_FLOW_RATE > 0;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MASSOILCALC');
END
$procedure$
