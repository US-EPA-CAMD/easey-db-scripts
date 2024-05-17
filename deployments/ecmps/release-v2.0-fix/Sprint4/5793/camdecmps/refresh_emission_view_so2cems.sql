CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_so2cems(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
declare 
	dhvParamCodes text[] := ARRAY['SO2', 'H2O', 'HI', 'SO2R'];
	mhvParamCodes text[] := ARRAY['FLOW', 'SO2C', 'H20'];
BEGIN
  CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmps.EMISSION_VIEW_SO2CEMS 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmps.EMISSION_VIEW_SO2CEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		UNADJ_SO2,
		SO2_BAF,
		RPT_ADJ_SO2,
		CALC_ADJ_SO2,
		SO2_MODC,
		SO2_PMA,
		UNADJ_FLOW,
		FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		SO2_FORMULA_CD,
		RPT_SO2_MASS_RATE,
		CALC_SO2_MASS_RATE,
		CALC_HI_RATE,
		DEFAULT_SO2_EMISSION_RATE,
		ERROR_CODES
	)
	SELECT DISTINCT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		HOD.OP_TIME, 
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		MHV.SO2C_UNADJUSTED_HRLY_VALUE AS UNADJ_SO2, 
		MHV.SO2C_APPLICABLE_BIAS_ADJ_FACTOR AS SO2_BAF, 
		MHV.SO2C_ADJUSTED_HRLY_VALUE AS RPT_ADJ_SO2, 
		MHV.SO2C_CALC_ADJUSTED_HRLY_VALUE  AS CALC_ADJ_SO2, 
		MHV.SO2C_MODC_CD AS SO2_MODC, 
		MHV.SO2C_PCT_AVAILABLE AS SO2_PMA,
		MHV.FLOW_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
		MHV.FLOW_APPLICABLE_BIAS_ADJ_FACTOR AS FLOW_BAF, 
		MHV.FLOW_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
		MHV.FLOW_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED, 
		MHV.FLOW_MODC_CD AS FLOW_MODC, 
		MHV.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		DHV.SO2_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE 
			WHEN (DHV.SO2_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE 
					WHEN (DHV.H2o_MODC_CD IS NOT NULL) THEN DHV.H2o_MODC_CD 
					WHEN (MHV.H2o_MODC_CD IS NOT NULL) THEN MHV.H2o_MODC_CD 
					ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		MF.EQUATION_CD AS SO2_FORMULA_CD, 
		DHV.SO2_ADJUSTED_HRLY_VALUE AS RPT_SO2_MASS_RATE, 
		DHV.SO2_CALC_ADJUSTED_HRLY_VALUE AS CALC_SO2_MASS_RATE, 
		CASE (MF.EQUATION_CD) WHEN 'F-23' THEN DHV.HI_CALC_ADJUSTED_HRLY_VALUE END AS CALC_HI_RATE, 
		CASE (MF.EQUATION_CD) WHEN 'F-23' THEN Coalesce(DHV.SO2R_ADJUSTED_HRLY_VALUE, camdecmps.emissions_get_default_so2_rate(HOD.MON_LOC_ID, HOD.BEGIN_DATE, HOD.BEGIN_HOUR)) END AS DEFAULT_SO2_EMISSION_RATE,
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors HOD 
	JOIN camdecmps.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			so2_hour_id character varying,
			so2_mon_sys_id character varying,
			so2_mon_form_id character varying,
			so2_adjusted_hrly_value numeric,
			so2_calc_adjusted_hrly_value numeric,
			so2_unadjusted_hrly_value numeric,
			so2_calc_unadjusted_hrly_value numeric,
			so2_applicable_bias_adj_factor numeric,
			so2_calc_pct_moisture numeric,
			so2_calc_pct_diluent numeric,
			so2_pct_available numeric,
			so2_segment_num numeric,
			so2_operating_condition_cd character varying,
			so2_fuel_cd character varying,
			so2_modc_cd character varying,
			h2o_hour_id character varying,
			h2o_mon_sys_id character varying,
			h2o_mon_form_id character varying,
			h2o_adjusted_hrly_value numeric,
			h2o_calc_adjusted_hrly_value numeric,
			h2o_unadjusted_hrly_value numeric,
			h2o_calc_unadjusted_hrly_value numeric,
			h2o_applicable_bias_adj_factor numeric,
			h2o_calc_pct_moisture numeric,
			h2o_calc_pct_diluent numeric,
			h2o_pct_available numeric,
			h2o_segment_num numeric,
			h2o_operating_condition_cd character varying,
			h2o_fuel_cd character varying,
			h2o_modc_cd character varying,
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
			hi_modc_cd character varying,
			so2r_hour_id character varying,
			so2r_mon_sys_id character varying,
			so2r_mon_form_id character varying,
			so2r_adjusted_hrly_value numeric,
			so2r_calc_adjusted_hrly_value numeric,
			so2r_unadjusted_hrly_value numeric,
			so2r_calc_unadjusted_hrly_value numeric,
			so2r_applicable_bias_adj_factor numeric,
			so2r_calc_pct_moisture numeric,
			so2r_calc_pct_diluent numeric,
			so2r_pct_available numeric,
			so2r_segment_num numeric,
			so2r_operating_condition_cd character varying,
			so2r_fuel_cd character varying,
			so2r_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT JOIN camdecmps.MONITOR_FORMULA  MF 
		ON DHV.so2_MON_FORM_ID = MF.MON_FORM_ID 
	LEFT JOIN camdecmps.get_monitor_hourly_values_pivoted(
		  vmonplanid, vrptperiodid, mhvParamCodes
		) AS mhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			flow_hour_id character varying,
			flow_adjusted_hrly_value numeric,
			flow_calc_adjusted_hrly_value numeric,
			flow_unadjusted_hrly_value numeric,
			flow_applicable_bias_adj_factor numeric,
			flow_pct_available numeric,
			flow_moisture_basis character varying,
			flow_modc_cd character varying,
			so2c_hour_id character varying,
			so2c_adjusted_hrly_value numeric,
			so2c_calc_adjusted_hrly_value numeric,
			so2c_unadjusted_hrly_value numeric,
			so2c_applicable_bias_adj_factor numeric,
			so2c_pct_available numeric,
			so2c_moisture_basis character varying,
			so2c_modc_cd character varying,
			h2o_hour_id character varying,
			h2o_adjusted_hrly_value numeric,
			h2o_calc_adjusted_hrly_value numeric,
			h2o_unadjusted_hrly_value numeric,
			h2o_applicable_bias_adj_factor numeric,
			h2o_pct_available numeric,
			h2o_moisture_basis character varying,
			h2o_modc_cd character varying
		)	ON mhv.HOUR_ID = hod.HOUR_ID
			AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT  H2O_MD 
		ON HOD.MON_LOC_ID = H2O_MD.MON_LOC_ID AND H2O_MD.DEFAULT_PURPOSE_CD = 'PM' AND H2O_MD.PARAMETER_CD = 'H2O' 
		AND (camdecmps.emissions_monitor_default_active(H2O_MD.BEGIN_DATE, H2O_MD.BEGIN_HOUR, H2O_MD.END_DATE, H2O_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)
	WHERE dhv.so2_hour_id is not null
	and mhv.flow_hour_id is not null;

  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'SO2CEMS');
END
$procedure$
