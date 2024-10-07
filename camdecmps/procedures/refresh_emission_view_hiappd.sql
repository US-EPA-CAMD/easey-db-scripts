CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_hiappd
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    monlocids text[];
BEGIN
    
    select  array
            (
                select  MON_LOC_ID
                  from  camdecmps.MONITOR_PLAN_LOCATION
                 where  MON_PLAN_ID = vmonplanid
            )
      into  monLocIds;    
    
    RAISE NOTICE 'Loading temp_hourly_test_errors...';
    CALL camdecmps.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);

    RAISE NOTICE 'Deleting existing records...';
    DELETE FROM camdecmps.EMISSION_VIEW_HIAPPD    WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
    INSERT INTO camdecmps.EMISSION_VIEW_HIAPPD(        MON_PLAN_ID,        MON_LOC_ID,        RPT_PERIOD_ID,        DATE_HOUR,        OP_TIME,        FUEL_SYS_ID,        FUEL_TYPE,        FUEL_USE_TIME,        UNIT_LOAD,        LOAD_UOM,        RPT_FUEL_FLOW,        CALC_FUEL_FLOW,        FUEL_FLOW_UOM,        FUEL_FLOW_SODC,        GROSS_CALORIFIC_VALUE,        GCV_UOM,        GCV_SAMPLING_TYPE,        FORMULA_CD,        RPT_HI_RATE,        CALC_HI_RATE,        ERROR_CODES    )    SELECT  hod.MON_PLAN_ID, 
            hod.MON_LOC_ID, 
            hod.RPT_PERIOD_ID, 
            camdecmps.format_date_hour(hod.BEGIN_DATE, hod.BEGIN_HOUR, null) AS DATE_HOUR,
            hod.OP_TIME, 
            COALESCE( ms.SYSTEM_IDENTIFIER, '' ) AS FUEL_SYS_ID,
            hff.FUEL_CD AS FUEL_TYPE,
            hff.FUEL_USAGE_TIME AS FUEL_USE_TIME,
            hod.HR_LOAD AS UNIT_LOAD, 
            hod.LOAD_UOM_CD AS LOAD_UOM,
            CASE
                WHEN ( ( fc.FUEL_GROUP_CD = 'GAS' ) OR ( mf.EQUATION_CD = 'F-19V' ) ) THEN hff.VOLUMETRIC_FLOW_RATE
                ELSE hff.MASS_FLOW_RATE
            END AS RPT_FUEL_FLOW,
            CASE
                WHEN  ( ( fc.FUEL_GROUP_CD = 'GAS' ) OR ( mf.EQUATION_CD = 'F-19V' ) ) THEN hff.CALC_VOLUMETRIC_FLOW_RATE
                ELSE hff.CALC_MASS_FLOW_RATE
            END AS CALC_FUEL_FLOW,
            CASE
                WHEN ((fc.FUEL_GROUP_CD = 'GAS') OR (mf.EQUATION_CD = 'F-19V')) THEN hff.VOLUMETRIC_UOM_CD
                ELSE 'LBHR'
            END AS FUEL_FLOW_UOM,
            CASE
                WHEN  ( ( fc.FUEL_GROUP_CD = 'GAS' ) OR ( mf.EQUATION_CD = 'F-19V' ) ) THEN hff.SOD_VOLUMETRIC_CD
                ELSE hff.SOD_MASS_CD
            END AS FUEL_FLOW_SODC,
            hpff.GCV_PARAM_VAL_FUEL AS GROSS_CALORIFIC_VALUE,
            hpff.GCV_PARAMETER_UOM_CD AS GCV_UOM,
            hpff.GCV_SAMPLE_TYPE_CD AS GCV_SAMPLING_TYPE,
            mf.EQUATION_CD AS FORMULA_CD,
            hpff.HI_PARAM_VAL_FUEL AS RPT_HI_RATE,
            hpff.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
            hod.ERROR_CODES
      FROM  (
                select  sel.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        sel.RPT_PERIOD_ID,
                        hod.HOUR_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ' ' as ERROR_CODES
                  from  (
                            select  vmonplanid as MON_PLAN_ID,
                                    vrptperiodid as RPT_PERIOD_ID
                        ) sel
                        join camdecmps.MONITOR_PLAN_LOCATION mpl
                          on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
                        join camdecmps.EMISSION_EVALUATION ems
                          on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                         and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
                        join camdecmps.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = ems.rpt_period_id
                         and hod.mon_loc_id = mpl.mon_loc_id
            ) AS hod
            join camdecmps.HRLY_FUEL_FLOW hff
              on hff.HOUR_ID = hod.HOUR_ID
             and hff.MON_LOC_ID = hod.MON_LOC_ID
             and hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
            join
            (
                select  hff.hrly_fuel_flow_id,
                        hff.hour_id,
                        hff.mon_loc_id,
                        hff.rpt_period_id,                
                        gcv.param_val_fuel              as gcv_param_val_fuel,               
                        gcv.sample_type_cd              as gcv_sample_type_cd,              
                        gcv.parameter_uom_cd            as gcv_parameter_uom_cd, 
                        hi.mon_form_id                  as hi_mon_form_id,
                        hi.param_val_fuel               as hi_param_val_fuel,              
                        hi.calc_param_val_fuel          as hi_calc_param_val_fuel
                  from  camdecmps.HRLY_FUEL_FLOW hff
                        left join
                        (
                            select  hrly_fuel_flow_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    mon_form_id,
                                    param_val_fuel,
                                    calc_param_val_fuel,
                                    sample_type_cd,
                                    parameter_uom_cd
                              from  camdecmps.HRLY_PARAM_FUEL_FLOW
                             where  mon_loc_id = any( monlocids )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'GCV'
                        ) gcv
                          on gcv.hrly_fuel_flow_id = hff.hrly_fuel_flow_id
                         and gcv.mon_loc_id = hff.mon_loc_id
                         and gcv.rpt_period_id = hff.rpt_period_id
                        left join
                        (
                            select  hrly_fuel_flow_id,
                                    mon_loc_id,
                                    rpt_period_id,
                                    mon_form_id,
                                    param_val_fuel,
                                    calc_param_val_fuel,
                                    sample_type_cd,
                                    parameter_uom_cd
                              from  camdecmps.HRLY_PARAM_FUEL_FLOW
                             where  mon_loc_id = any( monlocids )
                               and  rpt_period_id = vrptperiodid
                               and  parameter_cd = 'HI'
                        ) hi
                          on hi.hrly_fuel_flow_id = hff.hrly_fuel_flow_id
                         and hi.mon_loc_id = hff.mon_loc_id
                         and hi.rpt_period_id = hff.rpt_period_id
                 where  hff.MON_LOC_ID = any( monlocids )
                   and  hff.RPT_PERIOD_ID = vrptperiodid
            ) hpff
              on hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
             and hpff.HOUR_ID = hff.HOUR_ID
             and hpff.MON_LOC_ID = hff.MON_LOC_ID
             and hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
        left join camdecmps.MONITOR_FORMULA mf
            on mf.MON_FORM_ID = hpff.HI_MON_FORM_ID
        left join camdecmps.MONITOR_SYSTEM ms
            on ms.MON_SYS_ID = hff.MON_SYS_ID
        left join camdecmpsmd.FUEL_CODE fc
            on fc.FUEL_CD = hff.FUEL_CD;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIAPPD');
    RAISE NOTICE 'Refresh complete @ % %', CURRENT_DATE, CURRENT_TIME;
END
$procedure$
