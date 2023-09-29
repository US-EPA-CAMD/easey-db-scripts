-- FUNCTION: camdecmpswks.combined_hourly_value_data(character varying, numeric, character varying)

DROP FUNCTION IF EXISTS camdecmpswks.combined_hourly_value_data(character varying, numeric, character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.combined_hourly_value_data(
	monplanid character varying,
	rptperiodid numeric,
	parametercd character varying)
    RETURNS TABLE(mon_plan_id character varying, rpt_period_id numeric, begin_date date, begin_hour numeric, mon_loc_id character varying, op_time numeric, parameter_cd character varying, hrly_value numeric, adjusted_hrly_value numeric, unadjusted_hrly_value numeric, modc_cd character varying, source_table character varying, hour_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN  
    RETURN QUERY
        select mpl.MON_PLAN_ID,
               dhv.RPT_PERIOD_ID,
               hod.BEGIN_DATE,
               hod.BEGIN_HOUR,
               dhv.MON_LOC_ID,
               hod.OP_TIME,
               dhv.PARAMETER_CD,
               dhv.ADJUSTED_HRLY_VALUE HRLY_VALUE,
               dhv.ADJUSTED_HRLY_VALUE,
               dhv.UNADJUSTED_HRLY_VALUE,
               dhv.MODC_CD,
               'DHV'::varchar SOURCE_TABLE,
               hod.HOUR_ID
          from camdecmpswks.MONITOR_PLAN_LOCATION mpl
               join camdecmpswks.HRLY_OP_DATA hod
                 on hod.MON_LOC_ID = mpl.MON_LOC_ID
                    and (rptPeriodId is null or hod.RPT_PERIOD_ID = rptPeriodId)
               join camdecmpswks.DERIVED_HRLY_VALUE dhv
                 on dhv.HOUR_ID = hod.HOUR_ID
                    and (parameterCd is null or dhv.PARAMETER_CD = parameterCd)
          where (monPlanId is null or mpl.MON_PLAN_ID = monPlanId)
        union
        select mpl.MON_PLAN_ID,
               mhv.RPT_PERIOD_ID,
               hod.BEGIN_DATE,
               hod.BEGIN_HOUR,
               mhv.MON_LOC_ID,
               hod.OP_TIME,
               mhv.PARAMETER_CD,
               case
                 when mhv.PARAMETER_CD in ('CO2C', 'H2O', 'NOXC', 'O2C') 
                   then mhv.UNADJUSTED_HRLY_VALUE
                 else mhv.ADJUSTED_HRLY_VALUE
               end HRLY_VALUE,
               mhv.ADJUSTED_HRLY_VALUE,
               mhv.UNADJUSTED_HRLY_VALUE,
               mhv.MODC_CD,
               'MHV'::varchar SOURCE_TABLE,
               hod.HOUR_ID
          from camdecmpswks.MONITOR_PLAN_LOCATION mpl
               join camdecmpswks.HRLY_OP_DATA hod
                 on hod.MON_LOC_ID = mpl.MON_LOC_ID
                    and (rptPeriodId is null or hod.RPT_PERIOD_ID = rptPeriodId)
               join camdecmpswks.MONITOR_HRLY_VALUE mhv
                 on mhv.HOUR_ID = hod.HOUR_ID
                    and (parameterCd is null or mhv.PARAMETER_CD = parameterCd)
          where (monPlanId is null or mpl.MON_PLAN_ID = monPlanId);

END;
$BODY$;
