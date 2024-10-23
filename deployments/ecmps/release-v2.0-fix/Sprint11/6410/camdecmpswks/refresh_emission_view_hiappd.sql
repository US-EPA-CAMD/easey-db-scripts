CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_hiappd
(
    IN vmonplanid character varying,
    IN vrptperiodid NUMERIC
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
BEGIN

    RAISE NOTICE 'Deleting existing records...';
    DELETE FROM camdecmpswks.EMISSION_VIEW_HIAPPD    WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
    INSERT INTO camdecmpswks.EMISSION_VIEW_HIAPPD(        MON_PLAN_ID,        MON_LOC_ID,        RPT_PERIOD_ID,        DATE_HOUR,        OP_TIME,        FUEL_SYS_ID,        FUEL_TYPE,        FUEL_USE_TIME,        UNIT_LOAD,        LOAD_UOM,        RPT_FUEL_FLOW,        CALC_FUEL_FLOW,        FUEL_FLOW_UOM,        FUEL_FLOW_SODC,        GROSS_CALORIFIC_VALUE,        GCV_UOM,        GCV_SAMPLING_TYPE,        FORMULA_CD,        RPT_HI_RATE,        CALC_HI_RATE,        ERROR_CODES    )    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID, 
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) AS DATE_HOUR,
            dat.OP_TIME, 
            dat.SYSTEM_IDENTIFIER AS FUEL_SYS_ID,
            dat.FUEL_CD AS FUEL_TYPE,
            dat.FUEL_USAGE_TIME AS FUEL_USE_TIME,
            dat.HR_LOAD AS UNIT_LOAD, 
            dat.LOAD_UOM_CD AS LOAD_UOM,
            CASE
                WHEN ( ( dat.FUEL_GROUP_CD = 'GAS' ) OR ( dat.HI_FORMULA_CD = 'F-19V' ) )
                THEN dat.VOLUMETRIC_FLOW_RATE
                ELSE dat.MASS_FLOW_RATE
            END AS RPT_FUEL_FLOW,
            CASE
                WHEN  ( ( dat.FUEL_GROUP_CD = 'GAS' ) OR ( dat.HI_FORMULA_CD = 'F-19V' ) )
                THEN dat.CALC_VOLUMETRIC_FLOW_RATE
                ELSE dat.CALC_MASS_FLOW_RATE
            END AS CALC_FUEL_FLOW,
            CASE
                WHEN ( ( dat.FUEL_GROUP_CD = 'GAS') OR (dat.HI_FORMULA_CD = 'F-19V' ) )
                THEN dat.VOLUMETRIC_UOM_CD
                ELSE 'LBHR'
            END AS FUEL_FLOW_UOM,
            CASE
                WHEN  ( ( dat.FUEL_GROUP_CD = 'GAS' ) OR ( dat.HI_FORMULA_CD = 'F-19V' ) )
                THEN dat.SOD_VOLUMETRIC_CD
                ELSE dat.SOD_MASS_CD
            END AS FUEL_FLOW_SODC,
            dat.GCV_PARAM_VAL_FUEL AS GROSS_CALORIFIC_VALUE,
            dat.GCV_PARAMETER_UOM_CD AS GCV_UOM,
            dat.GCV_SAMPLE_TYPE_CD AS GCV_SAMPLING_TYPE,
            dat.HI_FORMULA_CD AS FORMULA_CD,
            dat.HI_PARAM_VAL_FUEL AS RPT_HI_RATE,
            dat.HI_CALC_PARAM_VAL_FUEL AS CALC_HI_RATE,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as error_codes
      from  (
                select  hod.HOUR_ID,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ems.CHK_SESSION_ID,
                        -- HFF
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        hff.MASS_FLOW_RATE,
                        hff.CALC_MASS_FLOW_RATE,
                        hff.VOLUMETRIC_FLOW_RATE,
                        hff.CALC_VOLUMETRIC_FLOW_RATE,
                        hff.VOLUMETRIC_UOM_CD,
                        hff.SOD_MASS_CD,
                        hff.SOD_VOLUMETRIC_CD,
                        sys.SYSTEM_IDENTIFIER,
                        fue.FUEL_GROUP_CD,
                        -- GCV HPFF
                        max( case when hpff.PARAMETER_CD = 'GCV' then hpff.PARAM_VAL_FUEL end ) as GCV_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'GCV' then hpff.PARAMETER_UOM_CD end ) as GCV_PARAMETER_UOM_CD,
                        max( case when hpff.PARAMETER_CD = 'GCV' then hpff.SAMPLE_TYPE_CD end ) as GCV_SAMPLE_TYPE_CD,
                        -- HI HPFF
                        max( case when hpff.PARAMETER_CD = 'HI'  then hpff.HRLY_FUEL_FLOW_ID end ) as HI_HRLY_FUEL_FLOW_ID,
                        max( case when hpff.PARAMETER_CD = 'HI'  then hpff.PARAM_VAL_FUEL end ) as HI_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'HI'  then hpff.CALC_PARAM_VAL_FUEL end ) as HI_CALC_PARAM_VAL_FUEL,
                        max( case when hpff.PARAMETER_CD = 'HI'  then frm.EQUATION_CD end ) as HI_FORMULA_CD
                  from  (
                            select  vmonplanid as MON_PLAN_ID,
                                    vrptperiodid as RPT_PERIOD_ID
                        ) sel
                        join camdecmpswks.MONITOR_PLAN_LOCATION mpl
                          on mpl.MON_PLAN_ID = sel.MON_PLAN_ID
                        join camdecmpswks.EMISSION_EVALUATION ems
                          on ems.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                         and ems.MON_PLAN_ID = mpl.MON_PLAN_ID
                        join camdecmpswks.HRLY_OP_DATA hod 
                          on hod.rpt_period_id = ems.rpt_period_id
                         and hod.mon_loc_id = mpl.mon_loc_id
                        join camdecmpswks.HRLY_FUEL_FLOW hff
                          on hff.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and hff.MON_LOC_ID = hod.MON_LOC_ID
                         and hff.HOUR_ID = hod.HOUR_ID
                        left join camdecmpswks.MONITOR_SYSTEM sys
                          on sys.MON_SYS_ID = hff.MON_SYS_ID
                        left join camdecmpsmd.FUEL_CODE fue
                          on fue.FUEL_CD = hff.FUEL_CD
                        join camdecmpswks.HRLY_PARAM_FUEL_FLOW hpff
                          on hpff.RPT_PERIOD_ID = hff.RPT_PERIOD_ID
                         and hpff.MON_LOC_ID = hff.MON_LOC_ID
                         and hpff.HRLY_FUEL_FLOW_ID = hff.HRLY_FUEL_FLOW_ID
                         and hpff.PARAMETER_CD in ( 'GCV', 'HI' )
                        left join camdecmpswks.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = hpff.MON_FORM_ID
                 group
                    by  hod.HOUR_ID,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ems.CHK_SESSION_ID,
                        hff.FUEL_CD,
                        hff.FUEL_USAGE_TIME,
                        hff.MASS_FLOW_RATE,
                        hff.CALC_MASS_FLOW_RATE,
                        hff.VOLUMETRIC_FLOW_RATE,
                        hff.CALC_VOLUMETRIC_FLOW_RATE,
                        hff.VOLUMETRIC_UOM_CD,
                        hff.SOD_MASS_CD,
                        hff.SOD_VOLUMETRIC_CD,
                        sys.SYSTEM_IDENTIFIER,
                        fue.FUEL_GROUP_CD
            ) dat
     where  dat.HI_HRLY_FUEL_FLOW_ID is not null;

    RAISE NOTICE 'Refreshing view counts...';
    CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'HIAPPD');
    RAISE NOTICE 'Refresh complete @ % %', CURRENT_DATE, CURRENT_TIME;
END
$procedure$
