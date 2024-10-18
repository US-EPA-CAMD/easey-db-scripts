CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_noxmasscems
(
    IN vmonplanid character varying,
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLARE 
BEGIN
	DELETE FROM camdecmps.EMISSION_VIEW_NOXMASSCEMS
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;

	INSERT INTO camdecmps.EMISSION_VIEW_NOXMASSCEMS(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		UNADJ_NOX,		CALC_NOX_BAF,		RPT_ADJ_NOX,		ADJ_NOX_USED,		NOX_MODC,		NOX_PMA,		UNADJ_FLOW,		CALC_FLOW_BAF,		RPT_ADJ_FLOW,		ADJ_FLOW_USED,		FLOW_MODC,		FLOW_PMA,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		NOX_MASS_FORMULA_CD,		RPT_NOX_MASS,		CALC_NOX_MASS,		ERROR_CODES	)    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            camdecmps.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.HR_LOAD as UNIT_LOAD,
            dat.LOAD_UOM_CD as LOAD_UOM,
            dat.NOXC_UNADJUSTED_HRLY_VALUE as UNADJ_FLOW, 
            dat.NOXC_APPLICABLE_BIAS_ADJ_FACTOR as CALC_FLOW_BAF, 
            dat.NOXC_ADJUSTED_HRLY_VALUE as RPT_ADJ_FLOW, 
            dat.NOXC_CALC_ADJUSTED_HRLY_VALUE as ADJ_FLOW_USED, 
            dat.NOXC_MODC_CD as FLOW_MODC, 
            dat.NOXC_PCT_AVAILABLE as FLOW_PMA,
            dat.FLOW_UNADJUSTED_HRLY_VALUE as UNADJ_FLOW, 
            dat.FLOW_APPLICABLE_BIAS_ADJ_FACTOR as CALC_FLOW_BAF, 
            dat.FLOW_ADJUSTED_HRLY_VALUE as RPT_ADJ_FLOW, 
            dat.FLOW_CALC_ADJUSTED_HRLY_VALUE as ADJ_FLOW_USED, 
            dat.FLOW_MODC_CD as FLOW_MODC, 
            dat.FLOW_PCT_AVAILABLE as FLOW_PMA,
            dat.NOX_CALC_PCT_MOISTURE as PCT_H2O_USED,
            case 
                when ( dat.NOX_CALC_PCT_MOISTURE is not null ) then 
                    case 
                        when ( dat.H2O_MHV_MODC_CD is not null ) then dat.H2O_MHV_MODC_CD 
                        when ( dat.H2O_DHV_MODC_CD is not null ) then dat.H2O_DHV_MODC_CD 
                        else 'DF'
                    end 
                else null
            end as SOURCE_H2O_VALUE,
            dat.NOX_FORMULA_CD,
            dat.NOX_ADJUSTED_HRLY_VALUE as RPT_NOX_MASS,
            dat.NOX_CALC_ADJUSTED_HRLY_VALUE as CALC_NOX_MASS,
            (
                select  case when max( coalesce( sev.SEVERITY_LEVEL, 0 ) ) > 0 then 'Y' else NULL end
                  from  camdecmpsaux.CHECK_LOG chl
                        left join camdecmpsmd.SEVERITY_CODE sev
                          on sev.SEVERITY_CD = chl.SEVERITY_CD
                 where  chl.CHK_SESSION_ID = dat.CHK_SESSION_ID
                   and  chl.MON_LOC_ID = dat.MON_LOC_ID
                   and  ( chl.OP_BEGIN_DATE < dat.BEGIN_DATE or ( chl.OP_BEGIN_DATE = dat.BEGIN_DATE and chl.OP_BEGIN_HOUR <= dat.BEGIN_HOUR ) )
                   and  ( chl.OP_END_DATE > dat.BEGIN_DATE or ( chl.OP_END_DATE = dat.BEGIN_DATE and chl.OP_END_HOUR >= dat.BEGIN_HOUR ) )
            ) as ERROR_CODES
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
                        hod.LOAD_RANGE, 
                        hod.COMMON_STACK_LOAD_RANGE,
                        hod.FC_FACTOR,
                        hod.FD_FACTOR,
                        hod.FW_FACTOR,
                        hod.FUEL_CD,
                        ems.CHK_SESSION_ID,
                        -- NOX
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.HOUR_ID end ) as NOX_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.ADJUSTED_HRLY_VALUE end ) as NOX_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOX_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then dhv.CALC_PCT_MOISTURE end ) as NOX_CALC_PCT_MOISTURE,
                        max( case when dhv.PARAMETER_CD = 'NOX'  then frm.EQUATION_CD end ) as NOX_FORMULA_CD,
                        -- H2O DHV
                        max( case when dhv.PARAMETER_CD = 'H2O'  then dhv.MODC_CD end ) as H2O_DHV_MODC_CD,
                        -- FLOW
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.HOUR_ID end ) as FLOW_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.ADJUSTED_HRLY_VALUE end ) as FLOW_ADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.UNADJUSTED_HRLY_VALUE end ) as FLOW_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.MODC_CD end ) as FLOW_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.PCT_AVAILABLE end ) as FLOW_PCT_AVAILABLE,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.APPLICABLE_BIAS_ADJ_FACTOR end ) as FLOW_APPLICABLE_BIAS_ADJ_FACTOR,
                        max( case when mhv.PARAMETER_CD = 'FLOW' then mhv.CALC_ADJUSTED_HRLY_VALUE end ) as FLOW_CALC_ADJUSTED_HRLY_VALUE,
                        -- NOXC
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.ADJUSTED_HRLY_VALUE end ) as NOXC_ADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.UNADJUSTED_HRLY_VALUE end ) as NOXC_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.MODC_CD end ) as NOXC_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.PCT_AVAILABLE end ) as NOXC_PCT_AVAILABLE,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.APPLICABLE_BIAS_ADJ_FACTOR end ) as NOXC_APPLICABLE_BIAS_ADJ_FACTOR,
                        max( case when mhv.PARAMETER_CD = 'NOXC' then mhv.CALC_ADJUSTED_HRLY_VALUE end ) as NOXC_CALC_ADJUSTED_HRLY_VALUE,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD
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
                        join camdecmps.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'H2O', 'NOX' )
                        join camdecmps.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'FLOW', 'H2O', 'NOXC' )
                        join camdecmps.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
                         and dhv.PARAMETER_CD = 'NOX'
                         and frm.EQUATION_CD like 'F-26%'
                 group
                    by  hod.hour_id,
                        mpl.MON_PLAN_ID, 
                        hod.MON_LOC_ID, 
                        hod.RPT_PERIOD_ID,
                        hod.BEGIN_DATE,
                        hod.BEGIN_HOUR,
                        hod.OP_TIME,
                        hod.HR_LOAD,
                        hod.LOAD_UOM_CD,
                        ems.CHK_SESSION_ID
        ) dat
 where  dat.NOX_HOUR_ID is not null
   and  dat.FLOW_HOUR_ID is not null;

  CALL camdecmps.refresh_emission_view_count(vmonplanid, vrptperiodid, 'NOXMASSCEMS');
END
$procedure$
