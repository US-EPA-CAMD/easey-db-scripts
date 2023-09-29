-- FUNCTION: camdecmpswks.hour_before_supp_data_previous_quarter_for_system(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.hour_before_supp_data_previous_quarter_for_system(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.hour_before_supp_data_previous_quarter_for_system(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(mon_loc_id character varying, hourly_type_cd character varying, parameter_cd character varying, moisture_basis character varying, mon_sys_id character varying, op_datehour timestamp without time zone, unadjusted_hrly_value numeric, adjusted_hrly_value numeric, hrly_value numeric, last_qa_value_supp_data_id character varying, rpt_period_id numeric, mon_plan_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
    previousQuarterRptPeriodId  integer;
BEGIN  

    if rptPeriodId IS NULL then
        previousQuarterRptPeriodId := NULL;
    else
        select  prv.RPT_PERIOD_ID
          into  previousQuarterRptPeriodId
          from  camdecmpsmd.REPORTING_PERIOD cur
                left join camdecmpsmd.REPORTING_PERIOD prv on ( 4 * prv.CALENDAR_YEAR + prv.QUARTER ) = ( 4 * cur.CALENDAR_YEAR + cur.QUARTER ) - 1
         where  cur.RPT_PERIOD_ID = rptPeriodId;
    end if;
		

    RETURN QUERY    
        select  mpl.MON_LOC_ID,
                xrf.HOURLY_TYPE_CD,
                xrf.PARAMETER_CD,
                xrf.MOISTURE_BASIS,
                msy.MON_SYS_ID,
                sup.OP_DATEHOUR,
                sup.UNADJUSTED_HRLY_VALUE,
                sup.ADJUSTED_HRLY_VALUE,
                case
                    when sup.HOURLY_TYPE_CD = 'DERIVED' and xrf.DERIVED_VALUE_SOURCE = 'ADJUSTED_HRLY_VALUE' then sup.ADJUSTED_HRLY_VALUE
                    when sup.HOURLY_TYPE_CD = 'DERIVED' and xrf.DERIVED_VALUE_SOURCE = 'UNADJUSTED_HRLY_VALUE' then sup.UNADJUSTED_HRLY_VALUE
                    when sup.HOURLY_TYPE_CD = 'MONITOR' and xrf.MONITOR_VALUE_SOURCE = 'ADJUSTED_HRLY_VALUE' then sup.ADJUSTED_HRLY_VALUE
                    when sup.HOURLY_TYPE_CD = 'MONITOR' and xrf.MONITOR_VALUE_SOURCE = 'UNADJUSTED_HRLY_VALUE' then sup.UNADJUSTED_HRLY_VALUE
                    else null
                end::numeric as HRLY_VALUE,
                sup.LAST_QA_VALUE_SUPP_DATA_ID,
                sup.RPT_PERIOD_ID,
                mpl.MON_PLAN_ID
          from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                join camdecmpsmd.REPORTING_PERIOD prd
                  on ( previousQuarterRptPeriodId is null or prd.RPT_PERIOD_ID = previousQuarterRptPeriodId )
                join camdecmpsmd.HBHA_SUPP_DATA_XREF xrf 
                  on exists ( 
                                select  1
                                  from  camdecmpswks.MONITOR_PLAN_LOCATION ex1
                                        join camdecmpswks.LAST_QA_VALUE_SUPP_DATA ex2 on ex2.MON_LOC_ID = ex1.MON_LOC_ID
                                 where  ex1.MON_PLAN_ID = mpl.MON_PLAN_ID
                                   and  ex2.RPT_PERIOD_ID = prd.RPT_PERIOD_ID
                                   and  ( ex2.HOURLY_TYPE_CD = xrf.HOURLY_TYPE_CD or xrf.HOURLY_TYPE_CD = 'COMBINE' )
                                   and  ex2.PARAMETER_CD = xrf.PARAMETER_CD
                                   and  (
                                            -- Match if mositure basis are both null or the same value
                                            coalesce(ex2.MOISTURE_BASIS, 'n') = coalesce(xrf.MOISTURE_BASIS, 'n')
                                            or
                                            -- Match supplemental moisture bases is null but cross reference moisture basis is not null
                                            coalesce(ex2.MOISTURE_BASIS, xrf.MOISTURE_BASIS) = xrf.MOISTURE_BASIS
                                        )
                            )
                join camdecmpswks.MONITOR_SYSTEM msy 
                  on xrf.PRIMARY_BYPASS_IND = 1
                 and exists ( 
                                select  1
                                    from  camdecmpswks.MONITOR_SYSTEM exs 
                                    where  exs.MON_LOC_ID = mpl.MON_LOC_ID
                                    and  exs.SYS_DESIGNATION_CD = 'PB'
                                    and  exs.BEGIN_DATE <= prd.END_DATE
                                    and  coalesce(exs.END_DATE, prd.END_DATE) >= prd.BEGIN_DATE
                            )
                 and msy.MON_LOC_ID = mpl.MON_LOC_ID
                 and msy.SYS_TYPE_CD = 'NOX'
                 and msy.SYS_DESIGNATION_CD in ('P', 'PB')
                 and msy.BEGIN_DATE <= prd.END_DATE
                 and coalesce(msy.END_DATE, prd.END_DATE) >= prd.BEGIN_DATE
                left join camdecmpswks.LAST_QA_VALUE_SUPP_DATA sup
                  on sup.MON_LOC_ID = mpl.MON_LOC_ID 
                 and sup.RPT_PERIOD_ID = prd.RPT_PERIOD_ID
                 and sup.MON_SYS_ID = msy.MON_SYS_ID
                 and sup.COMPONENT_ID is null
                 and ( sup.HOURLY_TYPE_CD = xrf.HOURLY_TYPE_CD or xrf.HOURLY_TYPE_CD = 'COMBINE' )
                 and sup.PARAMETER_CD = xrf.PARAMETER_CD
                 and (
                        -- No MOISTURE_BASIS comparison if XREF has null MOISTURE_BASIS
                        xrf.MOISTURE_BASIS is null
                        or
                        -- Match if MOISTURE_BASIS values are the same
                        sup.MOISTURE_BASIS = xrf.MOISTURE_BASIS
                        or
                        -- If supplemental MOISTURE_BASIS is null and XREF MOISTURE_BASIS does not have a direct match, then supplemental matches
                        sup.MOISTURE_BASIS is null
                        and
                        not exists
                        (
                            select  1
                              from  camdecmpswks.LAST_QA_VALUE_SUPP_DATA exs
                             where  exs.MON_LOC_ID = sup.MON_LOC_ID
                               and  exs.RPT_PERIOD_ID = sup.RPT_PERIOD_ID
                               and  exs.HOURLY_TYPE_CD = sup.HOURLY_TYPE_CD
                               and  exs.PARAMETER_CD = sup.PARAMETER_CD
                               and  exs.MON_SYS_ID is null
                               and  exs.COMPONENT_ID is null
                               and  exs.MOISTURE_BASIS = xrf.MOISTURE_BASIS
                               and  exs.LAST_QA_VALUE_SUPP_DATA_ID != sup.LAST_QA_VALUE_SUPP_DATA_ID
                        )
                     )
         where  ( monPlanId is null or mpl.MON_PLAN_ID = monPlanId );

END;
$BODY$;
