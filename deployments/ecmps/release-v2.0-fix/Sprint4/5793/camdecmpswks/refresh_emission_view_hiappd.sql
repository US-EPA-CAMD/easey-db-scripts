CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiappd(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    hpffParamCodes text[] := ARRAY['HI','GCV'];
BEGIN
      RAISE NOTICE 'Loading temp_hourly_test_errors...';
    CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

    RAISE NOTICE 'Deleting existing records...';
    DELETE FROM camdecmpswks.EMISSION_VIEW_HIAPPD
    WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

    RAISE NOTICE 'Refreshing view data...';
    INSERT INTO camdecmpswks.EMISSION_VIEW_HIAPPD(
        MON_PLAN_ID,
        MON_LOC_ID,
        RPT_PERIOD_ID,
        DATE_HOUR,
        OP_TIME,
        FUEL_SYS_ID,
        FUEL_TYPE,
        FUEL_USE_TIME,
        UNIT_LOAD,
        LOAD_UOM,
        RPT_FUEL_FLOW,
        CALC_FUEL_FLOW,
        FUEL_FLOW_UOM,
        FUEL_FLOW_SODC,
        GROSS_CALORIFIC_VALUE,
        GCV_UOM,
        GCV_SAMPLING_TYPE,
        FORMULA_CD,
        RPT_HI_RATE,
        CALC_HI_RATE,
        ERROR_CODES
    )
    SELECT
        hod.MON_PLAN_ID,
        hod.MON_LOC_ID,
        hod.RPT_PERIOD_ID,
        camdecmpswks.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
        hod.OP_TIME,
        COALESCE(ms.SYSTEM_IDENTIFIER, '') AS FUEL_SYS_ID,
        hff.FUEL_CD AS FUEL_TYPE,
        hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
        hod.HR_LOAD AS UNIT_LOAD,
        hod.LOAD_UOM_CD AS LOAD_UOM,
        CASE
            WHEN ((fc.FUEL_GROUP_CD = 'GAS') OR (mf.EQUATION_CD = 'F-19V')) THEN hff.VOLUMETRIC_FLOW_RATE
            ELSE hff.MASS_FLOW_RATE
        END AS RPT_FUEL_FLOW,
        CASE
            WHEN ((fc.FUEL_GROUP_CD = 'GAS') OR (mf.EQUATION_CD = 'F-19V')) THEN hff.CALC_VOLUMETRIC_FLOW_RATE
            ELSE hff.CALC_MASS_FLOW_RATE
        END AS CALC_FUEL_FLOW,
        CASE
            WHEN ((fc.FUEL_GROUP_CD = 'GAS') OR (mf.EQUATION_CD = 'F-19V')) THEN hff.VOLUMETRIC_UOM_CD
            ELSE 'LBHR'
        END AS FUEL_FLOW_UOM,
        CASE
            WHEN ((fc.FUEL_GROUP_CD = 'GAS') OR (mf.EQUATION_CD = 'F-19V')) THEN hff.SOD_VOLUMETRIC_CD
            ELSE hff.SOD_MASS_CD
        END AS FUEL_FLOW_SODC,
        hpff.GCV_PARAM_VAL_FUEL AS GROSS_CALORIFIC_VALUE,
        hpff.GCV_PARAMETER_UOM_CD AS GCV_UOM,
        hpff.GCV_SAMPLE_TYPE_CD AS GCV_SAMPLING_TYPE,
        mf.EQUATION_CD AS FORMULA_CD,
        hpff.HI_PARAM_VAL_FUEL AS RPT_HI_RATE,
        hpff.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
        hod.ERROR_CODES
    FROM temp_hourly_test_errors AS hod
    JOIN camdecmpswks.HRLY_FUEL_FLOW hff
        ON hff.HOUR_ID = hod.HOUR_ID
        AND hff.MON_LOC_ID = hod.MON_LOC_ID
        AND hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
    JOIN camdecmpswks.get_hourly_param_fuel_flow_pivoted(
      vmonplanid, vrptperiodid, hpffParamCodes
    ) AS hpff (
        hrly_fuel_flow_id character varying,
        hour_id character varying,
        mon_loc_id character varying,
        rpt_period_id numeric,
        hi_hrly_fuel_flow_id character varying,
        hi_mon_sys_id character varying,
        hi_mon_form_id character varying,
        hi_param_val_fuel numeric,
        hi_calc_param_val_fuel numeric,
        hi_segment_num numeric,
        hi_sample_type_cd character varying,
        hi_parameter_uom_cd character varying,
        hi_operating_condition_cd character varying,
        gcv_hrly_fuel_flow_id character varying,
        gcv_mon_sys_id character varying,
        gcv_mon_form_id character varying,
        gcv_param_val_fuel numeric,
        gcv_calc_param_val_fuel numeric,
        gcv_segment_num numeric,
        gcv_sample_type_cd character varying,
        gcv_parameter_uom_cd character varying,
        gcv_operating_condition_cd character varying
    )   ON hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
        AND hpff.HOUR_ID = hff.HOUR_ID
        AND hpff.MON_LOC_ID = hff.MON_LOC_ID
        AND hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
    LEFT JOIN camdecmpswks.MONITOR_FORMULA AS mf
        ON mf.MON_FORM_ID = hpff.HI_MON_FORM_ID
    LEFT JOIN camdecmpswks.MONITOR_SYSTEM ms
        ON ms.MON_SYS_ID = hff.MON_SYS_ID
    LEFT JOIN camdecmpsmd.FUEL_CODE fc
        ON fc.FUEL_CD = hff.FUEL_CD;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIAPPD');

    RAISE NOTICE 'Refresh complete @ % %', CURRENT_DATE, CURRENT_TIME;
END
$procedure$
