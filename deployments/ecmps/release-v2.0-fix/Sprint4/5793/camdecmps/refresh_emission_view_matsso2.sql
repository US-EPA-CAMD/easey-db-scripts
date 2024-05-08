CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_matsso2(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE  
    dhvParamCodes text[] := ARRAY['H2O'];
    mhvParamCodes text[] := ARRAY['SO2C', 'CO2C', 'FLOW', 'H2O', 'O2'];
    mhvMoistureParams text[] := ARRAY['O2C'];
    mhvMoistureCodes text[] := ARRAY['D', 'W'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_MATSSO2
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_MATSSO2(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		MATS_LOAD,
		MATS_STARTUP_SHUTDOWN,
		SO2_CONC_VALUE,
		SO2_CONC_MODC_CD,
		SO2_CONC_PMA,
		FLOW_RATE,
		FLOW_MODC,
		FLOW_PMA,
		RPT_PCT_DILUENT,
		DILUENT_PARAMETER,
		CALC_PCT_DILUENT,
		DILUENT_MODC,
		CALC_PCT_H2O,
		H2O_SOURCE,
		F_FACTOR,
		SO2_FORMULA_CD,
		RPT_SO2_RATE,
		CALC_SO2_RATE,
		SO2_UOM,
		SO2_MODC_CD,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID, 
		camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null),
		hod.OP_TIME, 
		hod.MATS_LOAD,
		hod.MATS_STARTUP_SHUTDOWN,
		mhv.SO2C_UNADJUSTED_HRLY_VALUE AS SO2_CONC_VALUE,
		mhv.SO2C_MODC_CD AS SO2_CONC_MODC_CD,
		mhv.SO2C_PCT_AVAILABLE AS SO2_CONC_PMA, 
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS FLOW_RATE,
		mhv.FLOW_MODC_CD AS FLOW_MODC,
		mhv.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		CASE 
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'SO2RE', 'HGRE' )) THEN NULL
		    WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'SO2RH', 'HGRH' )) THEN 
				CASE
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN mhv.CO2C_UNADJUSTED_HRLY_VALUE
				    WHEN mf.EQUATION_CD IN ('19-1', '19-4') THEN mhv.o2_d_UNADJUSTED_HRLY_VALUE
					WHEN mf.EQUATION_CD IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') THEN mhv.o2_w_UNADJUSTED_HRLY_VALUE
					ELSE NULL
				END
			ELSE NULL
		END AS RPT_PCT_DILUENT,
		CASE 
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'SO2RE', 'HGRE' )) THEN NULL
		    WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'SO2RH', 'HGRH' )) THEN 
				CASE 
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN 'CO2'
					WHEN mf.EQUATION_CD IN ('19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D') THEN 'O2'
					ELSE NULL
				END
			ELSE NULL
		END AS DILUENT_PARAMETER,
		mdhv.CALC_PCT_DILUENT AS CALC_PCT_DILUENT,
		CASE 
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'SO2RE', 'HGRE' )) THEN NULL
		    WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'SO2RH', 'HGRH' )) THEN 
				CASE 
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN mhv.CO2C_MODC_CD 
				    WHEN mf.EQUATION_CD IN ('19-1', '19-4') THEN mhv.o2_d_MODC_CD
					WHEN mf.EQUATION_CD IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') THEN mhv.o2_w_MODC_CD
					ELSE NULL 
				END
			ELSE NULL
		END AS DILUENT_MODC,
		mdhv.CALC_PCT_MOISTURE AS CALC_PCT_H2O,
		CASE 
			WHEN mdhv.CALC_PCT_MOISTURE IS NULL THEN NULL 
			WHEN dhv.h2o_MODC_CD IS NOT NULL THEN dhv.h2o_MODC_CD
			WHEN mhv.h2o_MODC_CD IS NOT NULL THEN mhv.h2o_MODC_CD
			ELSE 'DF'
		END AS H2O_SOURCE,
		CASE 
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'SO2RE', 'HGRE' )) THEN NULL
		    WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'SO2RH', 'HGRH' )) THEN 
				CASE
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN hod.FC_FACTOR
					WHEN mf.EQUATION_CD IN ('19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D') THEN hod.FD_FACTOR
				    WHEN mf.EQUATION_CD IN ('19-2') THEN hod.FW_FACTOR
					ELSE NULL
				END
			ELSE NULL
		END AS F_FACTOR,
		mf.EQUATION_CD AS SO2_FORMULA_CD,
		mdhv.UNADJUSTED_HRLY_VALUE AS RPT_SO2_RATE,
		mdhv.CALC_UNADJUSTED_HRLY_VALUE AS CALC_RPT_SO2_RATE,
		CASE 
			WHEN mdhv.PARAMETER_CD = 'HGRE' THEN 'lb/GWh'
			WHEN mdhv.PARAMETER_CD = 'HGRH' THEN 'lb/TBtu'
			WHEN mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'SO2RE') THEN 'lb/MWh'
			WHEN mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'SO2RH') THEN 'lb/mmBtu'
		END AS SO2_UOM,
		mdhv.MODC_CD AS SO2_MODC_CD,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod 
	JOIN camdecmps.MATS_DERIVED_HRLY_VALUE AS mdhv
		ON mdhv.HOUR_ID = HOD.HOUR_ID
		AND mdhv.MON_LOC_ID = HOD.MON_LOC_ID
		AND mdhv.RPT_PERIOD_ID = HOD.RPT_PERIOD_ID
		AND mdhv.PARAMETER_CD IN ( 'SO2RE', 'SO2RH' )
	LEFT JOIN camdecmps.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = mdhv.MON_FORM_ID
	LEFT JOIN camdecmps.get_derived_hourly_values_pivoted(
			vmonplanid, vrptperiodid, dhvParamCodes
		) AS dhv (
			hour_id character varying,
			mon_loc_id character varying,
			rpt_period_id numeric,
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
	JOIN camdecmps.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
		so2c_hour_id character varying,
		so2c_adjusted_hrly_value numeric,
		so2c_calc_adjusted_hrly_value numeric,
		so2c_unadjusted_hrly_value numeric,
		so2c_applicable_bias_adj_factor numeric,
		so2c_pct_available numeric,
		so2c_moisture_basis character varying,
		so2c_modc_cd character varying,
		co2c_hour_id character varying,
		co2c_adjusted_hrly_value numeric,
		co2c_calc_adjusted_hrly_value numeric,
		co2c_unadjusted_hrly_value numeric,
		co2c_applicable_bias_adj_factor numeric,
		co2c_pct_available numeric,
		co2c_moisture_basis character varying,
		co2c_modc_cd character varying,
		flow_hour_id character varying,
		flow_adjusted_hrly_value numeric,
		flow_calc_adjusted_hrly_value numeric,
		flow_unadjusted_hrly_value numeric,
		flow_applicable_bias_adj_factor numeric,
		flow_pct_available numeric,
		flow_moisture_basis character varying,
		flow_modc_cd character varying,
		h2o_hour_id character varying,
		h2o_adjusted_hrly_value numeric,
		h2o_calc_adjusted_hrly_value numeric,
		h2o_unadjusted_hrly_value numeric,
		h2o_applicable_bias_adj_factor numeric,
		h2o_pct_available numeric,
		h2o_moisture_basis character varying,
		h2o_modc_cd character varying,
		o2_hour_id character varying,
		o2_adjusted_hrly_value numeric,
		o2_calc_adjusted_hrly_value numeric,
		o2_unadjusted_hrly_value numeric,
		o2_applicable_bias_adj_factor numeric,
		o2_pct_available numeric,
		o2_moisture_basis character varying,
		o2_modc_cd character varying,
		o2_d_hour_id character varying,
		o2_d_adjusted_hrly_value numeric,
		o2_d_calc_adjusted_hrly_value numeric,
		o2_d_unadjusted_hrly_value numeric,
		o2_d_applicable_bias_adj_factor numeric,
		o2_d_pct_available numeric,
		o2_d_moisture_basis character varying,
		o2_d_modc_cd character varying,
		o2_w_hour_id character varying,
		o2_w_adjusted_hrly_value numeric,
		o2_w_calc_adjusted_hrly_value numeric,
		o2_w_unadjusted_hrly_value numeric,
		o2_w_applicable_bias_adj_factor numeric,
		o2_w_pct_available numeric,
		o2_w_moisture_basis character varying,
		o2_w_modc_cd character varying
	)	ON mhv.HOUR_ID = hod.HOUR_ID
		AND mhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSSO2');
END
$procedure$
