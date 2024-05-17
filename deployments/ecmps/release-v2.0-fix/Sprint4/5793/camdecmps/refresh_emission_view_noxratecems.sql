CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxratecems(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
declare 
    dhvParamCodes text[] := ARRAY['NOXR', 'HI', 'NOX', 'H2O'];
	mhvParamCodes text[] := ARRAY['NOXC', 'CO2C', 'H2O'];
	mhvMoistureParams text[] := ARRAY['O2C'];
    mhvMoistureCodes text[] := ARRAY['D', 'W'];
BEGIN
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

	DELETE FROM camdecmps.EMISSION_VIEW_NOXRATECEMS 
	WHERE MON_PLAN_ID = vmonplanid AND RPT_PERIOD_ID = vrptperiodid;

	INSERT INTO camdecmps.EMISSION_VIEW_NOXRATECEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		NOX_RATE_MODC,
		NOX_RATE_PMA,
		UNADJ_NOX,
		NOX_MODC,
		DILUENT_PARAM,
		PCT_DILUENT_USED,
		DILUENT_MODC,
		RPT_DILUENT,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		F_FACTOR,
		nox_rate_formula_cd,
		RPT_UNADJ_NOX_RATE,
		CALC_UNADJ_NOX_RATE,
		CALC_NOX_BAF,
		RPT_ADJ_NOX_RATE,
		CALC_ADJ_NOX_RATE,
		CALC_HI_RATE,
		nox_mass_formula_cd,
		RPT_NOX_MASS,
		CALC_NOX_MASS,
		ERROR_CODES
	)
	SELECT DISTINCT
		HOD.MON_PLAN_ID, 
		HOD.MON_LOC_ID, 
		HOD.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		HOD.OP_TIME, 
		HOD.HR_LOAD AS UNIT_LOAD, 
		HOD.LOAD_UOM_CD AS LOAD_UOM, 
		DHV.NOXR_MODC_CD AS NOX_RATE_MODC, 
		DHV.NOXR_PCT_AVAILABLE AS NOX_RATE_PMA,
		MHV.NOXC_UNADJUSTED_HRLY_VALUE AS UNADJ_NOX, 
		MHV.NOXC_MODC_CD AS NOX_MODC, 
		CASE WHEN (MF.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9', 'F-6')) THEN 'CO2' 
			 WHEN (MF.EQUATION_CD IN ('19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5')) THEN 'O2' 
			 ELSE NULL 
		END AS DILUENT_PARAM, 
		DHV.NOXR_CALC_PCT_DILUENT AS PCT_DILUENT_USED, 
		CASE WHEN (MF.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9', 'F-6')) THEN MHV.CO2C_MODC_CD
			 WHEN (MF.EQUATION_CD IN ('19-1', '19-4', 'F-5')) THEN MHV.O2C_D_MODC_CD
			 WHEN (MF.EQUATION_CD IN ('19-2', '19-3', '19-5', '19-3D', '19-5D')) THEN MHV.O2C_W_MODC_CD		 
		END AS DILUENT_MODC, 
		CASE WHEN (MF.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9', 'F-6')) THEN MHV.CO2C_UNADJUSTED_HRLY_VALUE
			 WHEN (MF.EQUATION_CD IN ('19-1', '19-4', 'F-5')) THEN MHV.O2C_D_UNADJUSTED_HRLY_VALUE
			 WHEN (MF.EQUATION_CD IN ('19-2', '19-3', '19-5', '19-3D', '19-5D')) THEN MHV.O2C_W_UNADJUSTED_HRLY_VALUE		 
		END as RPT_DILUENT,
		DHV.NOXR_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
		CASE 
			WHEN (DHV.NOXR_CALC_PCT_MOISTURE IS NOT NULL) THEN 
				CASE WHEN (DHV.H2O_MODC_CD IS NOT NULL) THEN DHV.H2O_MODC_CD 
					 WHEN (MHV.H2O_MODC_CD IS NOT NULL) THEN MHV.H2O_MODC_CD 
					 ELSE 'DF'
				END 
			ELSE NULL
		END AS SOURCE_H2O_VALUE, 
		CASE WHEN (MF.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9', 'F-6')) THEN HOD.FC_FACTOR 
			 WHEN (MF.EQUATION_CD IN ('19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D', 'F-5')) THEN HOD.FD_FACTOR 
			 WHEN (MF.EQUATION_CD = '19-2') THEN FW_FACTOR 
		END AS F_FACTOR, 
		MF.EQUATION_CD AS nox_rate_formula_cd, 
		DHV.NOXR_UNADJUSTED_HRLY_VALUE AS RPT_UNADJ_NOX_RATE, 
		DHV.NOXR_CALC_UNADJUSTED_HRLY_VALUE AS CALC_UNADJ_NOX_RATE, 
		DHV.NOXR_APPLICABLE_BIAS_ADJ_FACTOR AS CALC_NOX_BAF, 
		DHV.NOXR_ADJUSTED_HRLY_VALUE AS RPT_ADJ_NOX_RATE, 
		DHV.NOXR_CALC_ADJUSTED_HRLY_VALUE AS CALC_ADJ_NOX_RATE, 
		CASE WHEN NOX_MF.EQUATION_CD = 'F-24A' THEN DHV.HI_CALC_ADJUSTED_HRLY_VALUE 
			 ELSE NULL
		END AS CALC_HI_RATE, 
		CASE WHEN NOX_MF.EQUATION_CD = 'F-24A' THEN NOX_MF.EQUATION_CD
			 ELSE NULL
		END AS nox_mass_formula_cd,
		CASE WHEN NOX_MF.EQUATION_CD = 'F-24A' THEN DHV.NOX_ADJUSTED_HRLY_VALUE
			 ELSE NULL
		END AS RPT_NOX_MASS, 
		CASE WHEN NOX_MF.EQUATION_CD = 'F-24A' THEN DHV.NOX_CALC_ADJUSTED_HRLY_VALUE
			 ELSE NULL
		END AS CALC_NOX_MASS, 
		HOD.ERROR_CODES
	FROM temp_hourly_test_errors AS HOD 
	LEFT JOIN camdecmps.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
			noxr_hour_id character varying,
			noxr_mon_sys_id character varying,
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
			nox_hour_id character varying,
			nox_mon_sys_id character varying,
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
			h2o_modc_cd character varying
	) ON dhv.HOUR_ID = hod.HOUR_ID
		AND dhv.MON_LOC_ID = hod.MON_LOC_ID
		AND dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	left JOIN camdecmps.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		noxc_hour_id character varying,
		noxc_adjusted_hrly_value numeric,
		noxc_calc_adjusted_hrly_value numeric,
		noxc_unadjusted_hrly_value numeric,
		noxc_applicable_bias_adj_factor numeric,
		noxc_pct_available numeric,
		noxc_moisture_basis character varying,
		noxc_modc_cd character varying,
		co2c_hour_id character varying,
		co2c_adjusted_hrly_value numeric,
		co2c_calc_adjusted_hrly_value numeric,
		co2c_unadjusted_hrly_value numeric,
		co2c_applicable_bias_adj_factor numeric,
		co2c_pct_available numeric,
		co2c_moisture_basis character varying,
		co2c_modc_cd character varying,
		h2o_hour_id character varying,
		h2o_adjusted_hrly_value numeric,
		h2o_calc_adjusted_hrly_value numeric,
		h2o_unadjusted_hrly_value numeric,
		h2o_applicable_bias_adj_factor numeric,
		h2o_pct_available numeric,
		h2o_moisture_basis character varying,
		h2o_modc_cd character varying,
		o2c_d_hour_id character varying,
		o2c_d_adjusted_hrly_value numeric,
		o2c_d_calc_adjusted_hrly_value numeric,
		o2c_d_unadjusted_hrly_value numeric,
		o2c_d_applicable_bias_adj_factor numeric,
		o2c_d_pct_available numeric,
		o2c_d_moisture_basis character varying,
		o2c_d_modc_cd character varying,
		o2c_w_hour_id character varying,
		o2c_w_adjusted_hrly_value numeric,
		o2c_w_calc_adjusted_hrly_value numeric,
		o2c_w_unadjusted_hrly_value numeric,
		o2c_w_applicable_bias_adj_factor numeric,
		o2c_w_pct_available numeric,
		o2c_w_moisture_basis character varying,
		o2c_w_modc_cd character varying
	)	ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS MF 
		ON DHV.NOXR_MON_FORM_ID = MF.MON_FORM_ID 
	LEFT OUTER JOIN camdecmps.MONITOR_FORMULA AS NOX_MF 
		ON DHV.NOX_MON_FORM_ID = NOX_MF.MON_FORM_ID
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT AS H2O_MD 
		ON HOD.MON_LOC_ID = H2O_MD.MON_LOC_ID AND H2O_MD.DEFAULT_PURPOSE_CD = 'PM' AND H2O_MD.PARAMETER_CD = 'H2O' 
		AND (camdecmps.emissions_monitor_default_active(H2O_MD.BEGIN_DATE, H2O_MD.BEGIN_HOUR, H2O_MD.END_DATE, H2O_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT AS DEF_CO2N 
		ON HOD.MON_LOC_ID = DEF_CO2N.MON_LOC_ID AND DEF_CO2N.DEFAULT_PURPOSE_CD = 'DC' AND DEF_CO2N.PARAMETER_CD = 'CO2N' 
		AND (camdecmps.emissions_monitor_default_active(DEF_CO2N.BEGIN_DATE, DEF_CO2N.BEGIN_HOUR, DEF_CO2N.END_DATE, DEF_CO2N.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)
	LEFT OUTER JOIN camdecmps.MONITOR_DEFAULT AS DEF_O2X 
		ON HOD.MON_LOC_ID = DEF_O2X.MON_LOC_ID AND DEF_O2X.DEFAULT_PURPOSE_CD = 'DC' AND DEF_O2X.PARAMETER_CD = 'O2X' 
		AND (camdecmps.emissions_monitor_default_active(DEF_O2X.BEGIN_DATE, DEF_O2X.BEGIN_HOUR, DEF_O2X.END_DATE, DEF_O2X.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1)
	WHERE dhv.noxr_modc_cd is not null and dhv.noxr_hour_id is not null
		and (mhv.noxc_hour_id is null or mhv.noxc_modc_cd not in ('47', '48'))
		and (mhv.co2c_hour_id is null or mhv.co2c_modc_cd not in ('47', '48'))
		and (mhv.o2c_d_moisture_basis is null or mhv.o2c_d_moisture_basis = 'D')
		and (mhv.o2c_d_hour_id is null or mhv.o2c_d_modc_cd not in ('47', '48'))
		and (mhv.o2c_w_moisture_basis is null or mhv.o2c_w_moisture_basis = 'W')
		and (mhv.o2c_w_hour_id is null or mhv.o2c_w_modc_cd not in ('47', '48'));
	
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXRATECEMS');
END
$procedure$
