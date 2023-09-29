-- FUNCTION: camdecmpswks.nsps4t_compliance_period_data(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.nsps4t_compliance_period_data(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.nsps4t_compliance_period_data(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(oris_code numeric, location_name character varying, begin_year numeric, begin_month numeric, end_year numeric, end_month numeric, avg_co2_emission_rate numeric, co2_emission_rate_uom_cd character varying, co2_emission_rate_uom_label character varying, pct_valid_op_hours numeric, co2_violation_ind numeric, co2_violation_comment character varying, begin_month_ord numeric, end_month_ord numeric, nsps4t_cmp_id character varying, nsps4t_sum_id character varying, mon_plan_id character varying, rpt_period_id numeric, mon_loc_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
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
                left join camdecmpswks.STACK_PIPE stp 
                  on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                join camd.PLANT fac
                  on fac.FAC_ID in (unt.FAC_ID, stp.FAC_ID)
                left join camdecmpsmd.UNITS_OF_MEASURE_CODE uom
                  on uom.UOM_CD = cmp.CO2_EMISSION_RATE_UOM_CD;

END;
$BODY$;
