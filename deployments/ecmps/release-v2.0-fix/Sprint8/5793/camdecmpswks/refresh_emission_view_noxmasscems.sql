CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_noxmasscems(IN vmonplanid character varying, IN vrptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
    dhvParamCodes text[] := ARRAY['NOX', 'H2O', 'NOXR'];
    mhvParamCodes text[] := ARRAY['NOXC', 'FLOW', 'H2O'];

BEGIN

    CALL camdecmpswks.load_temp_hourly_test_errors(vMonPlanId, vRptPeriodId);



    DELETE FROM camdecmpswks.EMISSION_VIEW_NOXMASSCEMS

    WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;



    INSERT INTO camdecmpswks.EMISSION_VIEW_NOXMASSCEMS(
        MON_PLAN_ID,
        MON_LOC_ID,
        RPT_PERIOD_ID,
        DATE_HOUR,
        OP_TIME,
        UNIT_LOAD,
        LOAD_UOM,
        UNADJ_NOX,
        CALC_NOX_BAF,
        RPT_ADJ_NOX,
        ADJ_NOX_USED,
        NOX_MODC,
        NOX_PMA,
        UNADJ_FLOW,
        CALC_FLOW_BAF,
        RPT_ADJ_FLOW,
        ADJ_FLOW_USED,
        FLOW_MODC,
        FLOW_PMA,
        PCT_H2O_USED,
        SOURCE_H2O_VALUE,
        NOX_MASS_FORMULA_CD,
        RPT_NOX_MASS,
        CALC_NOX_MASS,
        ERROR_CODES
    )

    select  distinct
            hod.mon_plan_id,
            hod.mon_loc_id,
            hod.rpt_period_id,
            camdecmpswks.format_date_hour( hod.begin_date, hod.begin_hour, null ) AS date_hour,
            hod.op_time,
            hod.hr_load as unit_load,
            hod.load_uom_cd as load_uom,
            noxc.Unadjusted_Hrly_Value as unadjj_nox,
            noxc.Applicable_bias_adj_factor as calc_nox_baf,
            noxc.adjusted_hrly_value as rpt_adj_nox,
            noxc.calc_adjusted_hrly_value as rpt_adj_nox,
            noxc.modc_cd as nox_modc,
            noxc.pct_available as nox_p0ma,
            flow.unadjusted_hrly_value as unadj_flow,
            flow.applicable_bias_adj_factor as calc_flow_baf,
            flow.adjusted_hrly_value as rpt_adj_flow,
            flow.calc_adjusted_hrly_value as adj_flow_used,
            flow.modc_cd as flow_modc,
            flow.pct_available as flow_pma,
            nox.calc_pct_moisture as pct_h2o_used,
            case 
                when ( noxr.calc_pct_moisture is not null ) then 
                    case 
                        when ( h2o_m.modc_cd is not null ) then h2o_m.modc_cd 
                        when ( h2o_d.modc_cd is not null ) then h2o_d.modc_cd 
                        else 'DF'
                    end 
                else null
            end as source_h2o_value,
            frm.equation_cd as noxmass_formula_code,
            nox.adjusted_hrly_value as rpt_nox_mass,
            nox.calc_adjusted_hrly_value as calc_nox_mass,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpswks.EMISSION_EVALUATION ems
                        join camdecmpsaux.CHECK_LOG chl
                          on chl.chk_session_id = ems.chk_session_id
                         and chl.mon_loc_id = hod.mon_loc_id
                         and ( chl.op_begin_date < hod.begin_date or ( chl.op_begin_date = hod.begin_date and chl.op_begin_hour <= hod.begin_hour ) )
                         and ( chl.op_end_date > hod.begin_date or ( chl.op_end_date = hod.begin_date and chl.op_end_hour >= hod.begin_hour ) )
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.severity_cd = chl.severity_cd
            ) as error_codes
      from  (
                select  hod.hour_id,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD
                  from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                        join camdecmpswks.HRLY_OP_DATA hod on hod.mon_loc_id = mpl.mon_loc_id
                 where  mpl.mon_plan_id = vmonplanid
                   and  hod.rpt_period_id = vRptPeriodId
            ) as hod 
            join camdecmpswks.DERIVED_HRLY_VALUE nox
              on nox.hour_id = hod.hour_id
             and nox.parameter_cd = 'NOX'
            join camdecmpswks.MONITOR_HRLY_VALUE flow
              on flow.hour_id = hod.hour_id
             and flow.parameter_cd = 'FLOW'
            join camdecmpswks.MONITOR_FORMULA frm
              on frm.mon_form_id = nox.mon_form_id
             and frm.equation_cd like 'F-26%'
            left join camdecmpswks.MONITOR_HRLY_VALUE noxc
              on noxc.hour_id = hod.hour_id
             and noxc.parameter_cd = 'NOXC'
            left join camdecmpswks.MONITOR_HRLY_VALUE h2o_m
              on h2o_m.hour_id = hod.hour_id
             and h2o_m.parameter_cd = 'H2O'
            left join camdecmpswks.DERIVED_HRLY_VALUE h2o_d
              on h2o_d.hour_id = hod.hour_id
             and h2o_d.parameter_cd = 'H2O'
            left join camdecmpswks.DERIVED_HRLY_VALUE noxr
              on noxr.hour_id = hod.hour_id
             and noxr.parameter_cd = 'NOXR';


  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXMASSCEMS');

END

$procedure$