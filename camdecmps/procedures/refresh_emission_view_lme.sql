DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_lme(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_lme(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
	dhvParamCodes text[] := ARRAY['HIT','SO2M','NOXM','CO2M'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_LME
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_LME(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		HOUR_ID,
		HI_MODC,
		RPT_HEAT_INPUT,
		CALC_HEAT_INPUT,
		SO2M_FUEL_TYPE,
		SO2_EMISS_RATE,
		RPT_SO2_MASS,
		CALC_SO2_MASS,
		NOXM_FUEL_TYPE,
		OPERATING_CONDITION_CD,
		NOX_EMISS_RATE,
		RPT_NOX_MASS,
		CALC_NOX_MASS,
		CO2M_FUEL_TYPE,
		CO2_EMISS_RATE,
		RPT_CO2_MASS,
		CALC_CO2_MASS,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID,
		hod.MON_LOC_ID,
		hod.RPT_PERIOD_ID,
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME,
		hod.HR_LOAD as UNIT_LOAD,
		hod.LOAD_UOM_CD as LOAD_UOM,
		hod.HOUR_ID,
		dhv_HIT.MODC_CD as HI_MODC,
		dhv_HIT.ADJUSTED_HRLY_VALUE AS RPT_HEAT_INPUT,
		dhv_HIT.CALC_ADJUSTED_HRLY_VALUE AS CALC_HEAT_INPUT,
		dhv_SO2M.FUEL_CD as SO2M_FUEL_TYPE,
		md_SO2R.DEFAULT_VALUE as SO2_EMISS_RATE,
		dhv_SO2M.ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS,
		dhv_SO2M.CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS,
		dhv_NOXM.FUEL_CD as NOXM_FUEL_TYPE,
		dhv_NOXM.OPERATING_CONDITION_CD,
		CASE
			WHEN md_NOXR.MON_LOC_ID IS NOT NULL THEN md_NOXR.DEFAULT_VALUE
			WHEN md_NORX.MON_LOC_ID IS NOT NULL THEN md_NORX.DEFAULT_VALUE
			ELSE NULL
		END as NOX_EMISS_RATE,
		dhv_NOXM.ADJUSTED_HRLY_VALUE as RPT_NOX_MASS,
		dhv_NOXM.CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS,
		dhv_CO2M.FUEL_CD as CO2M_FUEL_TYPE,
		md_CO2R.DEFAULT_VALUE as CO2_EMISS_RATE,
		dhv_CO2M.ADJUSTED_HRLY_VALUE as RPT_CO2_MASS,
		dhv_CO2M.CALC_ADJUSTED_HRLY_VALUE as CALC_CO2_MASS,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmps.get_derived_hourly_values_pivoted(
	  vmonplanid, vrptperiodid, dhvParamCodes
	) AS dhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		hit_hour_id character varying,
		hit_mon_form_id character varying,
		hit_adjusted_hrly_value numeric,
		hit_calc_adjusted_hrly_value numeric,
		hit_unadjusted_hrly_value numeric,
		hit_calc_unadjusted_hrly_value numeric,
		hit_applicable_bias_adj_factor numeric,
		hit_calc_pct_moisture numeric,
		hit_calc_pct_diluent numeric,
		hit_pct_available numeric,
		hit_segment_num numeric,
		hit_operating_condition_cd character varying,
		hit_fuel_cd character varying,
		hit_modc_cd character varying,
		so2m_hour_id character varying,
		so2m_mon_form_id character varying,
		so2m_adjusted_hrly_value numeric,
		so2m_calc_adjusted_hrly_value numeric,
		so2m_unadjusted_hrly_value numeric,
		so2m_calc_unadjusted_hrly_value numeric,
		so2m_applicable_bias_adj_factor numeric,
		so2m_calc_pct_moisture numeric,
		so2m_calc_pct_diluent numeric,
		so2m_pct_available numeric,
		so2m_segment_num numeric,
		so2m_operating_condition_cd character varying,
		so2m_fuel_cd character varying,
		so2m_modc_cd character varying,
		noxm_hour_id character varying,
		noxm_mon_form_id character varying,
		noxm_adjusted_hrly_value numeric,
		noxm_calc_adjusted_hrly_value numeric,
		noxm_unadjusted_hrly_value numeric,
		noxm_calc_unadjusted_hrly_value numeric,
		noxm_applicable_bias_adj_factor numeric,
		noxm_calc_pct_moisture numeric,
		noxm_calc_pct_diluent numeric,
		noxm_pct_available numeric,
		noxm_segment_num numeric,
		noxm_operating_condition_cd character varying,
		noxm_fuel_cd character varying,
		noxm_modc_cd character varying,
		co2m_hour_id character varying,
		co2m_mon_form_id character varying,
		co2m_adjusted_hrly_value numeric,
		co2m_calc_adjusted_hrly_value numeric,
		co2m_unadjusted_hrly_value numeric,
		co2m_calc_unadjusted_hrly_value numeric,
		co2m_applicable_bias_adj_factor numeric,
		co2m_calc_pct_moisture numeric,
		co2m_calc_pct_diluent numeric,
		co2m_pct_available numeric,
		co2m_segment_num numeric,
		co2m_operating_condition_cd character varying,
		co2m_fuel_cd character varying,
		co2m_modc_cd character varying
	)ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_DEFAULT as md_SO2R 
		ON hod.MON_LOC_ID = md_SO2R.MON_LOC_ID
		AND camdecmps.emissions_monitor_default_active(md_SO2R.BEGIN_DATE, md_SO2R.BEGIN_HOUR, md_SO2R.END_DATE, md_SO2R.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1 
		AND md_SO2R.DEFAULT_PURPOSE_CD = 'LM'
		AND md_SO2R.DEFAULT_UOM_CD = 'LBMMBTU' 
		AND md_SO2R.FUEL_CD = dhv_SO2M.FUEL_CD 
		AND md_SO2R.PARAMETER_CD = 'SO2R'
	LEFT JOIN camdecmps.MONITOR_DEFAULT AS md_NOXR 
		ON md_NOXR.MON_LOC_ID = hod.MON_LOC_ID 
		AND camdecmps.emissions_monitor_default_active(md_NOXR.BEGIN_DATE, md_NOXR.BEGIN_HOUR, md_NOXR.END_DATE, md_NOXR.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1 
		AND md_NOXR.PARAMETER_CD = 'NOXR' 
		AND md_NOXR.DEFAULT_PURPOSE_CD = 'LM' 
		AND md_NOXR.DEFAULT_UOM_CD = 'LBMMBTU' 
		AND md_NOXR.FUEL_CD = dhv_NOXM.FUEL_CD 
		AND md_NOXR.OPERATING_CONDITION_CD != 'U'
		AND md_NOXR.OPERATING_CONDITION_CD = Coalesce(dhv_NOXM.OPERATING_CONDITION_CD,'A')  
	LEFT JOIN camdecmps.MONITOR_DEFAULT AS md_NORX 
		ON md_NORX.MON_LOC_ID = hod.MON_LOC_ID 
		AND camdecmps.emissions_monitor_default_active(md_NORX.BEGIN_DATE, md_NORX.BEGIN_HOUR, md_NORX.END_DATE, md_NORX.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1 
		AND md_NORX.PARAMETER_CD = 'NORX'
		AND md_NORX.DEFAULT_PURPOSE_CD = 'MD' 
		AND md_NORX.DEFAULT_UOM_CD = 'LBMMBTU' 
		AND md_NORX.FUEL_CD = dhv_NOXM.FUEL_CD 
		AND md_NORX.OPERATING_CONDITION_CD = 'U'
	LEFT JOIN camdecmps.MONITOR_DEFAULT AS md_CO2R 
		ON hod.MON_LOC_ID = md_CO2R.MON_LOC_ID
		AND	camdecmps.emissions_monitor_default_active(md_CO2R.BEGIN_DATE, md_CO2R.BEGIN_HOUR, md_CO2R.END_DATE, md_CO2R.END_HOUR, hod.BEGIN_DATE, hod.BEGIN_HOUR) = 1 
		AND md_CO2R.DEFAULT_PURPOSE_CD = 'LM' 
		AND md_CO2R.DEFAULT_UOM_CD ='TNMMBTU' 
		AND md_CO2R.FUEL_CD = dhv_CO2M.FUEL_CD 
		AND md_CO2R.PARAMETER_CD = 'CO2R'
	WHERE EXISTS (
		SELECT 1
		FROM camdecmps.DERIVED_HRLY_VALUE
		WHERE HOUR_ID = hod.HOUR_ID AND PARAMETER_CD IN (dhvParamCodes)
	);

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LME');
END
$BODY$;
