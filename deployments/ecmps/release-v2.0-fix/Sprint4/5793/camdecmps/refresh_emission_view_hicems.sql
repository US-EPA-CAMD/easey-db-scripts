CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_hicems(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE  
	dhvParamCodes text[] := ARRAY['HI', 'H2O'];
    mhvParamCodes text[] := ARRAY['FLOW', 'H2O', 'CO2C'];
    mhvMoistureParams text[] := ARRAY['O2C'];
    mhvMoistureCodes text[] := ARRAY['D', 'W'];
BEGIN
  RAISE NOTICE 'Loading temp_hourly_test_errors...';
	CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

  RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmps.EMISSION_VIEW_HICEMS
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

  RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmps.EMISSION_VIEW_HICEMS(
		MON_PLAN_ID,
		MON_LOC_ID,
		RPT_PERIOD_ID,
		HOUR_ID,
		DATE_HOUR,
		OP_TIME,
		UNIT_LOAD,
		LOAD_UOM,
		LOAD_RANGE,
		COMMON_STACK_LOAD_RANGE,
		HI_FORMULA_CD,
		HI_MODC,
		RPT_HI_RATE,
		CALC_HI_RATE,
		DILUENT_PARAM,
		RPT_PCT_DILUENT,
		PCT_DILUENT_USED,
		DILUENT_MODC,
		DILUENT_PMA,
		UNADJ_FLOW,
		CALC_FLOW_BAF,
		RPT_ADJ_FLOW,
		ADJ_FLOW_USED,
		FLOW_MODC,
		FLOW_PMA,
		PCT_H2O_USED,
		SOURCE_H2O_VALUE,
		F_FACTOR,
		ERROR_CODES,
		FUEL_CD
	)
    SELECT
        HOD.MON_PLAN_ID, 
        HOD.MON_LOC_ID, 
        HOD.RPT_PERIOD_ID,
        HOD.HOUR_ID,
        camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
        HOD.OP_TIME, 
        HOD.HR_LOAD AS UNIT_LOAD, 
        HOD.LOAD_UOM_CD AS LOAD_UOM, 
        HOD.LOAD_RANGE, 
        HOD.COMMON_STACK_LOAD_RANGE, 
        MF.EQUATION_CD AS HI_FORMULA_CD, 
        dhv.hi_MODC_CD AS HI_MODC,
        dhv.hi_ADJUSTED_HRLY_VALUE AS RPT_HI_RATE, 
        dhv.hi_CALC_ADJUSTED_HRLY_VALUE AS CALC_HI_RATE, 
        CASE MF.EQUATION_CD 
            WHEN 'F-15' THEN 'CO2' 
            WHEN 'F-16' THEN 'CO2' 
            WHEN 'F-17' THEN 'O2' 
            WHEN 'F-18' THEN 'O2' 
            ELSE NULL 
        END AS DILUENT_PARAM, 
        CASE MF.EQUATION_CD 
            WHEN 'F-15' THEN 
                mhv.co2c_UNADJUSTED_HRLY_VALUE 
            WHEN 'F-16' THEN 
                mhv.co2c_UNADJUSTED_HRLY_VALUE 
            WHEN 'F-17' THEN 
                mhv.o2c_w_UNADJUSTED_HRLY_VALUE
            WHEN 'F-18' THEN 
                mhv.o2c_d_UNADJUSTED_HRLY_VALUE
            ELSE NULL 
        END AS RPT_PCT_DILUENT, 
        dhv.hi_CALC_PCT_DILUENT AS PCT_DILUENT_USED,
        CASE MF.EQUATION_CD 
            WHEN 'F-15' THEN 
                MHV.co2c_MODC_CD
            WHEN 'F-16' THEN 
                mhv.co2c_MODC_CD
            WHEN 'F-17' THEN 
                mhv.o2c_w_MODC_CD
            WHEN 'F-18' THEN 
                mhv.o2c_d_MODC_CD
            ELSE NULL  
        END AS DILUENT_MODC, 
        CASE MF.EQUATION_CD 
            WHEN 'F-15' THEN 
                mhv.co2c_PCT_AVAILABLE
            WHEN 'F-16' THEN 
                mhv.co2c_PCT_AVAILABLE
            WHEN 'F-17' THEN 
               mhv.o2c_w_PCT_AVAILABLE
            WHEN 'F-18' THEN 
                mhv.o2c_d_PCT_AVAILABLE
            ELSE NULL 
        END AS DILUENT_PMA,
        mhv.flow_UNADJUSTED_HRLY_VALUE AS UNADJ_FLOW, 
        mhv.flow_APPLICABLE_BIAS_ADJ_FACTOR AS CALC_FLOW_BAF, 
        mhv.flow_ADJUSTED_HRLY_VALUE AS RPT_ADJ_FLOW, 
        mhv.flow_CALC_ADJUSTED_HRLY_VALUE AS ADJ_FLOW_USED, 
        mhv.flow_MODC_CD AS FLOW_MODC, 
        mhv.flow_PCT_AVAILABLE AS FLOW_PMA,
        dhv.hi_CALC_PCT_MOISTURE AS PCT_H2O_USED, 
        CASE 
            WHEN (dhv.hi_CALC_PCT_MOISTURE IS NOT NULL) THEN 
                CASE 
                    WHEN (dhv.h2o_MODC_CD IS NOT NULL) THEN dhv.h2o_MODC_CD 
                    WHEN (mhv.h2o_MODC_CD IS NOT NULL) THEN mhv.h2o_MODC_CD 
                    ELSE 'DF'
                END 
            ELSE NULL
        END AS SOURCE_H2O_VALUE, 
        CASE MF.EQUATION_CD 
            WHEN 'F-15' THEN HOD.FC_FACTOR 
            WHEN 'F-16' THEN HOD.FC_FACTOR 
            WHEN 'F-17' THEN HOD.FD_FACTOR 
            WHEN 'F-18' THEN HOD.FD_FACTOR 
        END AS F_FACTOR, 
        HOD.ERROR_CODES,
        hod.FUEL_CD
    FROM temp_hourly_test_errors AS HOD 
    LEFT JOIN camdecmps.get_derived_hourly_values_pivoted(
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
            hi_modc_cd character varying,
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
    LEFT JOIN camdecmps.MONITOR_FORMULA AS MF 
        ON dhv.hi_MON_FORM_ID = MF.MON_FORM_ID  
    LEFT JOIN camdecmps.get_monitor_hourly_values_pivoted(
            vmonplanid, vrptperiodid, mhvParamCodes, mhvMoistureParams, mhvMoistureCodes) AS mhv (
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
        h2o_hour_id character varying,
        h2o_adjusted_hrly_value numeric,
        h2o_calc_adjusted_hrly_value numeric,
        h2o_unadjusted_hrly_value numeric,
        h2o_applicable_bias_adj_factor numeric,
        h2o_pct_available numeric,
        h2o_moisture_basis character varying,
        h2o_modc_cd character varying,
        co2c_hour_id character varying,
        co2c_adjusted_hrly_value numeric,
        co2c_calc_adjusted_hrly_value numeric,
        co2c_unadjusted_hrly_value numeric,
        co2c_applicable_bias_adj_factor numeric,
        co2c_pct_available numeric,
        co2c_moisture_basis character varying,
        co2c_modc_cd character varying,
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
    )   ON mhv.HOUR_ID = hod.HOUR_ID
        AND mhv.MON_LOC_ID = hod.MON_LOC_ID
        AND mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
    LEFT JOIN camdecmps.MONITOR_DEFAULT AS H2O_MD 
        ON HOD.MON_LOC_ID = H2O_MD.MON_LOC_ID
        AND H2O_MD.DEFAULT_PURPOSE_CD = 'PM'
        AND H2O_MD.PARAMETER_CD = 'H2O'
        AND camdecmps.emissions_monitor_default_active(H2O_MD.BEGIN_DATE, H2O_MD.BEGIN_HOUR, H2O_MD.END_DATE, H2O_MD.END_HOUR, HOD.BEGIN_DATE, HOD.BEGIN_HOUR) = 1
    WHERE coalesce(mhv.o2c_d_modc_cd,'0') not in ('47','48') and coalesce(mhv.o2c_w_modc_cd,'0') not in ('47','48');

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HICEMS');
END
$procedure$
