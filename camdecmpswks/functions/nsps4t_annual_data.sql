CREATE OR REPLACE 
FUNCTION camdecmpswks.nsps4t_annual_data
(
	monPlanId       character varying,
	rptPeriodId     numeric
)
    RETURNS TABLE   (
                        ORIS_CODE                               numeric,
                        LOCATION_NAME                           character varying,
                        ANNUAL_ENERGY_SOLD                      numeric,
                        ANNUAL_ENERGY_SOLD_TYPE_CD              character varying,
                        ANNUAL_ENERGY_SOLD_TYPE_DESCRIPTION     character varying,
                        ANNUAL_POTENTIAL_OUTPUT                 numeric,
                        NSPS4T_ANN_ID                           character varying,
                        NSPS4T_SUM_ID                           character varying,
                        MON_PLAN_ID                             character varying,
                        RPT_PERIOD_ID                           numeric,
                        MON_LOC_ID                              character varying
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
                ann.ANNUAL_ENERGY_SOLD,
                ann.ANNUAL_ENERGY_SOLD_TYPE_CD,
                elc.ELECTRICAL_LOAD_DESCRIPTION as ANNUAL_ENERGY_SOLD_TYPE_DESCRIPTION,
                ann.ANNUAL_POTENTIAL_OUTPUT,
                ann.NSPS4T_ANN_ID,
                ann.NSPS4T_SUM_ID,
                sel.MON_PLAN_ID,
                sel.RPT_PERIOD_ID,
                sel.MON_LOC_ID
          from  sel
                join camdecmpswks.NSPS4T_ANNUAL ann 
                  on ann.MON_LOC_ID = sel.MON_LOC_ID
                 and ann.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                join camdecmpswks.MONITOR_LOCATION loc 
                  on loc.MON_LOC_ID = ann.MON_LOC_ID
                left join camd.UNIT unt 
                  on unt.UNIT_ID = loc.UNIT_ID
                left join camdecmpswks.STACK_PIPE stp 
                  on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                join camd.PLANT fac
                  on fac.FAC_ID in (unt.FAC_ID, stp.FAC_ID)
                left join camdecmpsmd.NSPS4T_ELECTRICAL_LOAD_CODE elc
                  on elc.ELECTRICAL_LOAD_CD = ann.ANNUAL_ENERGY_SOLD_TYPE_CD;

END;
$BODY$;