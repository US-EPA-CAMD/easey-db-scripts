DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_noxappemixedfuel(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxappemixedfuel(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
  dhvParamCodes text[] := ARRAY['NOXR','HI','NOX'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_NOXAPPEMIXEDFUEL
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_NOXAPPEMIXEDFUEL(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		SYSTEM_ID,
		UNIT_LOAD,
		LOAD_UOM,
		CALC_HI_RATE,
		OPERATING_CONDITION_CD,
		SEGMENT_NUMBER,
		RPT_NOX_EMISSION_RATE,
		CALC_NOX_EMISSION_RATE,
		NOX_MASS_RATE_FORMULA_CD,
		RPT_NOX_MASS_RATE,
		CALC_NOX_MASS_RATE,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME,
		ms_NOXR.SYSTEM_IDENTIFIER AS SYSTEM_ID,
		hod.HR_LOAD AS UNIT_LOAD, 
		hod.LOAD_UOM_CD AS LOAD_UOM, 
		dhv_HI.ADJUSTED_HRLY_VALUE AS CALC_HI_RATE,
		dhv_NOXR.OPERATING_CONDITION_CD,
		dhv_NOXR.SEGMENT_NUM AS SEGMENT_NUMBER,
		dhv_NOXR.ADJUSTED_HRLY_VALUE AS RPT_NOX_EMISSION_RATE,
		dhv_NOXR.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_EMISSION_RATE,
		mf_NOX.EQUATION_CD AS NOX_MASS_RATE_FORMULA_CD,
		dhv_NOX.ADJUSTED_HRLY_VALUE AS RPT_NOX_MASS_RATE,
		dhv_NOX.CALC_ADJUSTED_HRLY_VALUE AS CALC_NOX_MASS_RATE,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
		vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		noxr_hour_id character varying,
		noxr_mon_form_id character varying,
		noxr_adjusted_hrly_value numeric,
		noxr_calc_adjusted_hrly_value numeric,
		noxr_unadjusted_hrly_value numeric,
		noxr_calc_unadjusted_hrly_value numeric,
		noxr_applicable_bias_adj_factor numeric,
		noxr_calc_pct_moisture numeric,
		noxr_calc_pct_diluent numeric,
		noxr_pct_available numeric,
		noxr_segment_num numeric,
		noxr_operating_condition_cd character varying,
		noxr_fuel_cd character varying,
		noxr_modc_cd character varying,
		hi_hour_id character varying,
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
		hi_modc_cd character varying,
		nox_hour_id character varying,
		nox_mon_form_id character varying,
		nox_adjusted_hrly_value numeric,
		nox_calc_adjusted_hrly_value numeric,
		nox_unadjusted_hrly_value numeric,
		nox_calc_unadjusted_hrly_value numeric,
		nox_applicable_bias_adj_factor numeric,
		nox_calc_pct_moisture numeric,
		nox_calc_pct_diluent numeric,
		nox_pct_available numeric,
		nox_segment_num numeric,
		nox_operating_condition_cd character varying,
		nox_fuel_cd character varying,
		nox_modc_cd character varying,
	)ON dhv.HOUR_ID = hod.HOUR_ID
	  AND dhv.MON_LOC_ID = hod.MON_LOC_ID
	  AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	JOIN camdecmps.MONITOR_SYSTEM ms_NOXR  
		ON dhv_NOXR.MON_SYS_ID = ms_NOXR.MON_SYS_ID AND ms_NOXR.SYS_TYPE_CD='NOXE'
	LEFT JOIN camdecmps.MONITOR_FORMULA mf_NOX   
		ON dhv_NOX.MON_FORM_ID = mf_NOX.MON_FORM_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXAPPEMIXEDFUEL');
END
$BODY$;
