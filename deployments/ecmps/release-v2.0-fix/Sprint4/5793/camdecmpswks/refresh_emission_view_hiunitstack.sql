CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiunitstack(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
	dhvParamCodes text[] := ARRAY['HI'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_HIUNITSTACK
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_HIUNITSTACK(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		HI_FORMULA_CD,
		RPT_HI_RATE,
		CALC_HI_RATE,
		ERROR_CODES
	)
	SELECT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		HOD.OP_TIME, 
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		HOD.LOAD_RANGE, 
		HOD.COMMON_STACK_LOAD_RANGE, 
		MF.EQUATION_CD AS HI_FORMULA_CD, 
		DHV.hi_adjusted_hrly_value AS RPT_HI_RATE, 
		DHV.hi_calc_adjusted_hrly_value AS CALC_HI_RATE, 
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	JOIN camdecmpswks.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric, 
			hi_hour_id character varying,
			hi_mon_sys_id character varying,
			hi_mon_form_id character varying,
			hi_adjusted_hrly_value numeric,
			hi_calc_adjusted_hrly_value numeric,
			hi_unadjusted_hrly_value numeric,
			hi_calc_unadjusted_hrly_value numeric,
			hi_applicable_bias_adj_factor numeric,
			hi_calc_pct_moisture numeric,
			hi_calc_pct_diluent numeric,
			hi_pct_available numeric,
			hi_segment_num numeric,
			hi_operating_condition_cd character varying,
			hi_fuel_cd character varying,
			hi_modc_cd character varying
			) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmpswks.MONITOR_FORMULA AS MF 
		ON DHV.HI_MON_FORM_ID = MF.MON_FORM_ID
	LEFT JOIN camdecmpswks.MONITOR_HRLY_VALUE AS MHV 
		ON HOD.HOUR_ID = MHV.HOUR_ID
		AND HOD.MON_LOC_ID = MHV.MON_LOC_ID
		AND HOD.RPT_PERIOD_ID = MHV.RPT_PERIOD_ID		
		AND MHV.PARAMETER_CD = 'FLOW'
	WHERE mhv.parameter_cd IS NULL and dhv.hi_hour_id is not null;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIUNITSTACK');
END
$procedure$
