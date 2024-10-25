CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_co2cems
(
    IN vmonplanid character varying, 
    IN vrptperiodid numeric
)
 LANGUAGE plpgsql
AS $procedure$
DECLAREBEGIN
    RAISE NOTICE 'Deleting existing records...';
	DELETE FROM camdecmpswks.EMISSION_VIEW_CO2CEMS	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
    RAISE NOTICE 'Refreshing view data...';
	INSERT INTO camdecmpswks.EMISSION_VIEW_CO2CEMS(		MON_PLAN_ID,		MON_LOC_ID,		RPT_PERIOD_ID,		DATE_HOUR,		OP_TIME,		UNIT_LOAD,		LOAD_UOM,		COMPONENT_TYPE,		RPT_PCT_CO2,		PCT_CO2_USED,		CO2_MODC,		CO2_PMA,		UNADJ_FLOW,		CALC_FLOW_BAF,		RPT_ADJ_FLOW,		ADJ_FLOW_USED,		FLOW_MODC,		FLOW_PMA,		PCT_H2O_USED,		SOURCE_H2O_VALUE,		CO2_FORMULA_CD,		RPT_CO2_MASS_RATE,		CALC_CO2_MASS_RATE,		ERROR_CODES	)    select  dat.MON_PLAN_ID, 
            dat.MON_LOC_ID, 
            dat.RPT_PERIOD_ID,
            camdecmpswks.format_date_hour( dat.BEGIN_DATE, dat.BEGIN_HOUR, null ) as DATE_HOUR,
            dat.OP_TIME,
            dat.HR_LOAD as UNIT_LOAD,
            dat.LOAD_UOM_CD as LOAD_UOM,
            case 
                when ( dat.CO2C_DHV_HOUR_ID is not null ) then 'O2'
                when ( dat.CO2C_MHV_HOUR_ID is not null ) then 'CO2'
                else null
            end as COMPONENT_TYPE,
            case 
                when ( dat.CO2C_DHV_HOUR_ID is not null ) then dat.CO2C_DHV_ADJUSTED_HRLY_VALUE
                when ( dat.CO2C_MHV_HOUR_ID is not null ) then dat.CO2C_MHV_UNADJUSTED_HRLY_VALUE
                else null
            end as RPT_PCT_CO2,
            dat.CO2_CALC_PCT_DILUENT as PCT_CO2_USED,
            case 
                when ( dat.CO2C_DHV_HOUR_ID is not null ) then dat.CO2C_DHV_MODC_CD
                when ( dat.CO2C_MHV_HOUR_ID is not null ) then dat.CO2C_MHV_MODC_CD
                else null
            end as CO2_MODC,
                case 
                when ( dat.CO2C_DHV_HOUR_ID is not null ) then dat.CO2C_DHV_PCT_AVAILABLE
                when ( dat.CO2C_MHV_HOUR_ID is not null ) then dat.CO2C_MHV_PCT_AVAILABLE
                else null
            end as CO2_PMA,
            dat.FLOW_UNADJUSTED_HRLY_VALUE as UNADJ_FLOW,
            dat.FLOW_APPLICABLE_BIAS_ADJ_FACTOR as CALC_FLOW_BAF,   
            dat.FLOW_ADJUSTED_HRLY_VALUE as RPT_ADJ_FLOW,
            dat.FLOW_CALC_ADJUSTED_HRLY_VALUE as ADJ_FLOW_USED,
            dat.FLOW_MODC_CD as FLOW_MODC,
            dat.FLOW_PCT_AVAILABLE as FLOW_PMA,
            dat.CO2_CALC_PCT_MOISTURE as PCT_H2O_USED, 
            case
                when ( dat.CO2_CALC_PCT_MOISTURE is not null ) then 
                    case
                        when ( dat.H2O_DHV_MODC_CD is not null ) then dat.H2O_DHV_MODC_CD 
                        when ( dat.H2O_MHV_MODC_CD is not null ) then dat.H2O_MHV_MODC_CD 
                        else 'DF'
                    end 
                else null
            end as SOURCE_H2O_VALUE,
            dat.CO2_FORMULA_CD,
            dat.CO2_ADJUSTED_HRLY_VALUE as RPT_CO2_MASS_RATE,
            dat.CO2_CALC_ADJUSTED_HRLY_VALUE as CALC_CO2_MASS_RATE,
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
                        -- CO2
                        max( case when dhv.PARAMETER_CD = 'CO2'  then dhv.HOUR_ID end ) as CO2_DHV_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'CO2'  then dhv.ADJUSTED_HRLY_VALUE end ) as CO2_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2'  then dhv.CALC_ADJUSTED_HRLY_VALUE end ) as CO2_CALC_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2'  then dhv.CALC_PCT_DILUENT end ) as CO2_CALC_PCT_DILUENT,
                        max( case when dhv.PARAMETER_CD = 'CO2'  then dhv.CALC_PCT_MOISTURE end ) as CO2_CALC_PCT_MOISTURE,
                        max( case when dhv.PARAMETER_CD = 'CO2'  then frm.EQUATION_CD end ) as CO2_FORMULA_CD,
                        -- CO2C DHV
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.HOUR_ID end ) as CO2C_DHV_HOUR_ID,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.ADJUSTED_HRLY_VALUE end ) as CO2C_DHV_ADJUSTED_HRLY_VALUE,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.MODC_CD end ) as CO2C_DHV_MODC_CD,
                        max( case when dhv.PARAMETER_CD = 'CO2C' then dhv.PCT_AVAILABLE end ) as CO2C_DHV_PCT_AVAILABLE,
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
                        -- CO2C
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.HOUR_ID end ) as CO2C_MHV_HOUR_ID,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.UNADJUSTED_HRLY_VALUE end ) as CO2C_MHV_UNADJUSTED_HRLY_VALUE,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.MODC_CD end ) as CO2C_MHV_MODC_CD,
                        max( case when mhv.PARAMETER_CD = 'CO2C' then mhv.PCT_AVAILABLE end ) as CO2C_MHV_PCT_AVAILABLE,
                        -- H2O MHV
                        max( case when mhv.PARAMETER_CD = 'H2O'  then mhv.MODC_CD end ) as H2O_MHV_MODC_CD
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
                        left join camdecmpswks.MONITOR_HRLY_VALUE mhv
                          on mhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and mhv.MON_LOC_ID = hod.MON_LOC_ID
                         and mhv.HOUR_ID = hod.HOUR_ID
                         and mhv.PARAMETER_CD in ( 'FLOW', 'CO2C', 'H2O' )
                        left join camdecmpswks.DERIVED_HRLY_VALUE dhv
                          on dhv.RPT_PERIOD_ID = hod.RPT_PERIOD_ID
                         and dhv.MON_LOC_ID = hod.MON_LOC_ID
                         and dhv.HOUR_ID = hod.HOUR_ID
                         and dhv.PARAMETER_CD in ( 'CO2', 'CO2C', 'H2O' )
                        left join camdecmpswks.MONITOR_FORMULA frm
                          on frm.MON_FORM_ID = dhv.MON_FORM_ID
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
 where  (
            dat.CO2_DHV_HOUR_ID is not null and
            dat.FLOW_HOUR_ID is not null
        );

  RAISE NOTICE 'Refreshing view counts...';
  CALL camdecmpswks.refresh_emission_view_count(vmonplanid, vrptperiodid, 'CO2CEMS');
END
$procedure$
