CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_lme(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	dhvParamCodes text[] := ARRAY['SO2M', 'NOXM', 'CO2M','HIT'];
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
		dhv.hit_modc_cd as HI_MODC,
		dhv.hit_adjusted_hrly_value AS RPT_HEAT_INPUT,
		dhv.hit_calc_adjusted_hrly_value AS CALC_HEAT_INPUT,
		dhv.so2m_fuel_cd as SO2M_FUEL_TYPE,
		SO2R_MD.DEFAULT_VALUE as SO2_EMISS_RATE,
		dhv.so2m_adjusted_hrly_value AS RPT_SO2_MASS,
		dhv.so2m_calc_adjusted_hrly_value AS CALC_SO2_MASS,
		dhv.noxm_fuel_cd as NOXM_FUEL_TYPE,
		dhv.noxm_operating_condition_cd as OPERATING_CONDITION_CD,
		CASE
			WHEN NOXR_MD.MON_LOC_ID IS NOT NULL THEN NOXR_MD.DEFAULT_VALUE
			WHEN NORX_MD.MON_LOC_ID IS NOT NULL THEN NORX_MD.DEFAULT_VALUE
			ELSE NULL
		END as NOX_EMISS_RATE,
		dhv.noxm_adjusted_hrly_value as RPT_NOX_MASS,
		dhv.noxm_calc_adjusted_hrly_value as CALC_NOX_MASS,
		dhv.co2m_fuel_cd as CO2M_FUEL_TYPE,
		CO2R_MD.DEFAULT_VALUE as CO2_EMISS_RATE,
		dhv.co2m_adjusted_hrly_value as RPT_CO2_MASS,
		dhv.co2m_calc_adjusted_hrly_value as CALC_CO2_MASS,
		hod.ERROR_CODES
   FROM temp_hourly_test_errors AS hod 
    JOIN camdecmps.get_derived_hourly_values_pivoted(
            vmonplanid, vrptperiodid, dhvParamCodes
        ) AS dhv (
            hour_id character varying,
            mon_loc_id character varying,
            rpt_period_id numeric,
            so2m_hour_id character varying,
            so2m_mon_sys_id character varying,
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
            noxm_mon_sys_id character varying,
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
            co2m_mon_sys_id character varying,
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
            co2m_modc_cd character varying,
            hit_hour_id character varying,
            hit_mon_sys_id character varying,
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
            hit_modc_cd character varying
    ) ON dhv.HOUR_ID = hod.HOUR_ID
        AND dhv.MON_LOC_ID = hod.MON_LOC_ID
        AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
    LEFT JOIN camdecmps.MONITOR_DEFAULT as SO2R_MD 
        ON HOD.MON_LOC_ID = SO2R_MD.MON_LOC_ID
        AND camdecmps.emissions_monitor_default_active(SO2R_MD.BEGIN_DATE, SO2R_MD.BEGIN_HOUR, SO2R_MD.END_DATE, SO2R_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
        AND SO2R_MD.DEFAULT_PURPOSE_CD = 'LM'
        AND SO2R_MD.DEFAULT_UOM_CD = 'LBMMBTU' 
        AND SO2R_MD.FUEL_CD = DHV.so2m_fuel_cd 
        AND SO2R_MD.PARAMETER_CD = 'SO2R' 
    LEFT JOIN camdecmps.MONITOR_DEFAULT AS NOXR_MD 
        ON NOXR_MD.MON_LOC_ID = HOD.MON_LOC_ID 
        AND camdecmps.emissions_monitor_default_active(NOXR_MD.BEGIN_DATE, NOXR_MD.BEGIN_HOUR, NOXR_MD.END_DATE, NOXR_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
        AND NOXR_MD.PARAMETER_CD = 'NOXR' 
        AND NOXR_MD.DEFAULT_PURPOSE_CD = 'LM' 
        AND NOXR_MD.DEFAULT_UOM_CD = 'LBMMBTU' 
        AND NOXR_MD.FUEL_CD = DHV.noxm_fuel_cd 
        AND NOXR_MD.OPERATING_CONDITION_CD != 'U'
        AND NOXR_MD.OPERATING_CONDITION_CD = Coalesce(DHV.noxm_operating_condition_cd,'A')  
    LEFT JOIN camdecmps.MONITOR_DEFAULT AS NORX_MD 
        ON NORX_MD.MON_LOC_ID = HOD.MON_LOC_ID 
        AND camdecmps.emissions_monitor_default_active(NORX_MD.BEGIN_DATE, NORX_MD.BEGIN_HOUR, NORX_MD.END_DATE, NORX_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
        AND NORX_MD.PARAMETER_CD = 'NORX'
        AND NORX_MD.DEFAULT_PURPOSE_CD = 'MD' 
        AND NORX_MD.DEFAULT_UOM_CD = 'LBMMBTU' 
        AND NORX_MD.FUEL_CD = DHV.noxm_fuel_cd 
        AND NORX_MD.OPERATING_CONDITION_CD = 'U' 
    LEFT JOIN camdecmps.MONITOR_DEFAULT AS CO2R_MD 
        ON HOD.MON_LOC_ID = CO2R_MD.MON_LOC_ID
        AND camdecmps.emissions_monitor_default_active(CO2R_MD.BEGIN_DATE, CO2R_MD.BEGIN_HOUR, CO2R_MD.END_DATE, CO2R_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1 
        AND CO2R_MD.DEFAULT_PURPOSE_CD = 'LM' 
        AND CO2R_MD.DEFAULT_UOM_CD ='TNMMBTU' 
        AND CO2R_MD.FUEL_CD = DHV.co2m_fuel_cd 
        AND CO2R_MD.PARAMETER_CD = 'CO2R'
    where dhv.so2m_hour_id is not null or dhv.noxm_hour_id is not null or dhv.co2m_hour_id is not null or dhv.hit_hour_id is not null;

RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'LME');
END
$procedure$
