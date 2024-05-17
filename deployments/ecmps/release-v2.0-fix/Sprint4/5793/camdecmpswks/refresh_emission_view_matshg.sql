CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_matshg(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE  
    dhvParamCodes text[] := ARRAY['H2O'];
    mhvParamCodes text[] := ARRAY['CO2C', 'FLOW', 'H2O'];
    mhvMoistureParams text[] := ARRAY['O2C'];
    mhvMoistureCodes text[] := ARRAY['D', 'W'];
   
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_MATSHG
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_MATSHG(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		DATE_HOUR,
		OP_TIME,
		MATS_LOAD,
		MATS_STARTUP_SHUTDOWN,
		HG_CONC_VALUE,
		HG_CONC_SYSTEM_ID,
		HG_CONC_SYS_TYPE,
		HG_CONC_MODC_CD,
		HG_CONC_PMA,
		SAMPLING_TRAIN_COMP_ID1,
		GAS_FLOWMETER_READING1,
		RATIO_STACK_GAS_FLOW_RATE1,
		SAMPLING_TRAIN_COMP_ID2,
		GAS_FLOWMETER_READING2,
		RATIO_STACK_GAS_FLOW_RATE2,
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
		HG_FORMULA_CD,
		RPT_HG_RATE,
		CALC_HG_RATE,
		HG_UOM,
		HG_MODC_CD,
		ERROR_CODES
	)
	SELECT
		hod.MON_PLAN_ID, 
		hod.MON_LOC_ID, 
		hod.RPT_PERIOD_ID,
		camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
		hod.OP_TIME,
		hod.MATS_LOAD,
		hod.MATS_STARTUP_SHUTDOWN,
		mmhv.UNADJUSTED_HRLY_VALUE AS HG_CONC_VALUE, 
		ms.SYSTEM_IDENTIFIER AS HG_CONC_SYSTEM_ID, 
		stc.SYS_TYPE_DESCRIPTION AS HG_CONC_SYS_TYPE,
		mmhv.MODC_CD AS HG_CONC_MODC_CD,
		mmhv.PCT_AVAILABLE AS HG_CONC_PMA,
		cmp1.COMPONENT_IDENTIFIER AS SAMPLING_TRAIN_COMP_ID1,
		gfm1.GFM_READING AS GAS_FLOWMETER_READING1,
		gfm1.FLOW_TO_SAMPLING_RATIO AS RATIO_STACK_GAS_FLOW_RATE1,
		cmp2.COMPONENT_IDENTIFIER AS SAMPLING_TRAIN_COMP_ID2,
		gfm2.GFM_READING AS GAS_FLOWMETER_READING2,
		gfm2.FLOW_TO_SAMPLING_RATIO AS RATIO_STACK_GAS_FLOW_RATE2,
		mhv.FLOW_UNADJUSTED_HRLY_VALUE AS FLOW_RATE,
		mhv.FLOW_MODC_CD AS FLOW_MODC,
		mhv.FLOW_PCT_AVAILABLE AS FLOW_PMA,
		CASE
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'HGRE' )) THEN NULL
			WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'HGRH' )) THEN 
				CASE 
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN mhv.CO2C_UNADJUSTED_HRLY_VALUE
				  WHEN mf.EQUATION_CD IN ('19-1', '19-4') THEN mhv.o2c_d_UNADJUSTED_HRLY_VALUE
					WHEN mf.EQUATION_CD IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') THEN mhv.o2c_w_UNADJUSTED_HRLY_VALUE
					ELSE NULL
				END
			ELSE NULL
		END AS RPT_PCT_DILUENT,
		CASE
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'HGRE' )) THEN NULL
			WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'HGRH' )) THEN 
				CASE
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN 'CO2'
					WHEN mf.EQUATION_CD IN ('19-1', '19-2', '19-3', '19-3D', '19-4', '19-5', '19-5D') THEN 'O2'
					ELSE NULL
				END
			ELSE NULL
		END AS DILUENT_PARAMETER,
		mdhv.CALC_PCT_DILUENT AS CALC_PCT_DILUENT,
		CASE
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'HGRE' )) THEN NULL
			WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'HGRH' )) THEN 
				CASE
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN mhv.CO2C_MODC_CD 
					WHEN mf.EQUATION_CD IN ('19-1', '19-4') THEN mhv.o2c_d_MODC_CD
					WHEN mf.EQUATION_CD IN ('19-2', '19-3', '19-3D', '19-5', '19-5D') THEN mhv.o2c_w_MODC_CD
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
			WHEN (mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'HGRE' )) THEN NULL
			WHEN (mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'HGRH' )) THEN 
				CASE
					WHEN mf.EQUATION_CD IN ('19-6', '19-7', '19-8', '19-9') THEN hod.FC_FACTOR
					WHEN mf.EQUATION_CD IN ('19-1', '19-3', '19-3D', '19-4', '19-5', '19-5D') THEN hod.FD_FACTOR
					WHEN mf.EQUATION_CD IN ('19-2') THEN hod.FW_FACTOR
					ELSE NULL
				END
			ELSE NULL
		END AS F_FACTOR,
		mf.EQUATION_CD AS HG_FORMULA_CD,
		mdhv.UNADJUSTED_HRLY_VALUE AS RPT_HG_RATE,
		mdhv.CALC_UNADJUSTED_HRLY_VALUE AS CALC_HG_RATE,
		CASE
			WHEN mdhv.PARAMETER_CD = 'HGRE' THEN 'lb/GWh'
			WHEN mdhv.PARAMETER_CD = 'HGRH' THEN 'lb/TBtu'
			WHEN mdhv.PARAMETER_CD IN ('HCLRE', 'HFRE', 'SO2RE') THEN 'lb/MWh'
			WHEN mdhv.PARAMETER_CD IN ('HCLRH', 'HFRH', 'SO2RH') THEN 'lb/mmBtu'
		END AS HG_UOM,
		mdhv.MODC_CD AS HG_MODC_CD,
		hod.ERROR_CODES
	FROM temp_hourly_test_errors AS hod
	JOIN camdecmpswks.MATS_MONITOR_HRLY_VALUE AS mmhv 
		ON mmhv.HOUR_ID = hod.HOUR_ID
		AND mmhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mmhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND mmhv.PARAMETER_CD = 'HGC'
	JOIN camdecmpswks.MATS_DERIVED_HRLY_VALUE AS mdhv
		ON mdhv.HOUR_ID = hod.HOUR_ID
		AND mdhv.MON_LOC_ID = hod.MON_LOC_ID
		AND mdhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND mdhv.PARAMETER_CD IN ( 'HGRE', 'HGRH' )
	LEFT JOIN camdecmpswks.get_derived_hourly_values_pivoted(
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
	LEFT JOIN camdecmpswks.MONITOR_FORMULA AS mf
		ON mf.MON_FORM_ID = dhv.h2o_MON_FORM_ID		
	LEFT JOIN camdecmpswks.get_monitor_hourly_values_pivoted(
			vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
		hour_id character varying,
		mon_loc_id character varying,
		rpt_period_id numeric,
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
	LEFT JOIN camdecmpswks.MONITOR_SYSTEM AS ms 
		ON ms.MON_SYS_ID = mmhv.MON_SYS_ID
	LEFT JOIN camdecmpsmd.SYSTEM_TYPE_CODE AS stc 
		ON stc.SYS_TYPE_CD = ms.SYS_TYPE_CD
	LEFT JOIN camdecmpswks.HRLY_GAS_FLOW_METER gfm1 
		ON gfm1.HOUR_ID = hod.HOUR_ID 
		AND gfm1.MON_LOC_ID = hod.MON_LOC_ID
		AND gfm1.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND gfm1.COMPONENT_ID = camdecmpswks.mats_sampling_train_component( mmhv.MON_SYS_ID, hod.BEGIN_DATE, hod.BEGIN_HOUR, 1 )
	LEFT JOIN camdecmpswks.HRLY_GAS_FLOW_METER gfm2 
		ON gfm2.HOUR_ID = hod.HOUR_ID 
		AND gfm2.MON_LOC_ID = hod.MON_LOC_ID
		AND gfm2.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
		AND gfm2.COMPONENT_ID = camdecmpswks.mats_sampling_train_component( mmhv.MON_SYS_ID, hod.BEGIN_DATE, hod.BEGIN_HOUR, 2 )
	LEFT JOIN camdecmpswks.COMPONENT cmp1 
		ON cmp1.COMPONENT_ID = gfm1.COMPONENT_ID
	LEFT JOIN camdecmpswks.COMPONENT cmp2 
		ON cmp2.COMPONENT_ID = gfm2.COMPONENT_ID;

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'MATSHG');
END
$procedure$
