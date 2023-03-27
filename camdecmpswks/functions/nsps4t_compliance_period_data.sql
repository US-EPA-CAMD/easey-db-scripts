CREATE OR REPLACE 
FUNCTION camdecmpswks.nsps4t_compliance_period_data
(
	monPlanId       character varying,
	rptPeriodId     numeric
)
    RETURNS TABLE   (
                        ORIS_CODE                       numeric,
                        LOCATION_NAME                   character varying,
                        BEGIN_YEAR                      numeric,
                        BEGIN_MONTH                     numeric,
                        END_YEAR                        numeric,
                        END_MONTH                       numeric,
                        AVG_CO2_EMISSION_RATE           numeric,
                        CO2_EMISSION_RATE_UOM_CD        character varying,
                        CO2_EMISSION_RATE_UOM_LABEL     character varying,
                        PCT_VALID_OP_HOURS              numeric,
                        CO2_VIOLATION_IND               numeric,
                        CO2_VIOLATION_COMMENT           character varying,
                        BEGIN_MONTH_ORD                 numeric,
                        END_MONTH_ORD                   numeric,
                        NSPS4T_CMP_ID                   character varying,
                        NSPS4T_SUM_ID                   character varying,
                        MON_PLAN_ID                     character varying,
                        RPT_PERIOD_ID                   numeric,
                        MON_LOC_ID                      character varying
                    ) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN  
    RETURN QUERY
        with sel as
        (
            select  mpl.MON_PLAN_ID,
                    prd.RPT_PERIOD_ID,
                    mpl.MON_LOC_ID,
                    prd.BEGIN_DATE,
                    prd.END_DATE
              from  camdecmpswks.MONITOR_PLAN_LOCATION mpl,
                    camdecmpsmd.REPORTING_PERIOD prd
             where  (monPlanId is null or mpl.MON_PLAN_ID = monPlanId)
               and  (rptPeriodId is null or prd.RPT_PERIOD_ID = rptPeriodId)
        )
        select  fac.ORIS_CODE,
                coalesce(unt.UNITID, stp.STACK_NAME) as LOCATION_NAME,
                cmp.BEGIN_YEAR,
                cmp.BEGIN_MONTH,
                cmp.END_YEAR,
                cmp.END_MONTH,
                cmp.AVG_CO2_EMISSION_RATE,
                cmp.CO2_EMISSION_RATE_UOM_CD,
                uom.UOM_CD_DESCRIPTION as CO2_EMISSION_RATE_UOM_LABEL,
                cmp.PCT_VALID_OP_HOURS,
                cmp.CO2_VIOLATION_IND,
                cmp.CO2_VIOLATION_COMMENT,
                (12 * cmp.BEGIN_YEAR + cmp.BEGIN_MONTH) BEGIN_MONTH_ORD,
                (12 * cmp.END_YEAR + cmp.END_MONTH) END_MONTH_ORD,
                cmp.NSPS4T_CMP_ID,
                cmp.NSPS4T_SUM_ID,
                sel.MON_PLAN_ID,
                sel.RPT_PERIOD_ID,
                sel.MON_LOC_ID
          from  sel
                join camdecmpswks.NSPS4T_COMPLIANCE_PERIOD cmp 
                  on cmp.MON_LOC_ID = sel.MON_LOC_ID
                 and cmp.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                join camdecmpswks.MONITOR_LOCATION loc 
                  on loc.MON_LOC_ID = cmp.MON_LOC_ID
                left join camd.UNIT unt 
                  on unt.UNIT_ID = loc.UNIT_ID
                left join STACK_PIPE stp 
                  on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                join camd.PLANT fac
                  on fac.FAC_ID in (unt.FAC_ID, stp.FAC_ID)
                left join camdecmpsmd.UNITS_OF_MEASURE_CODE uom
                  on uom.UOM_CD = cmp.CO2_EMISSION_RATE_UOM_CD;

END;
$BODY$;