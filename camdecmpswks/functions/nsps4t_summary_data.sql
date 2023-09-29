-- FUNCTION: camdecmpswks.nsps4t_summary_data(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.nsps4t_summary_data(character varying, numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.nsps4t_summary_data(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(oris_code numeric, location_name character varying, emission_standard_cd character varying, emission_standard_load_cd character varying, emission_standard_uom_cd character varying, emission_standard_uom_label character varying, modus_value numeric, modus_uom_cd character varying, modus_uom_label character varying, electrical_load_cd character varying, no_period_ended_ind numeric, no_period_ended_comment character varying, nsps4t_sum_id character varying, mon_plan_id character varying, rpt_period_id numeric, mon_loc_id character varying) 
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
                smm.EMISSION_STANDARD_CD,
                stn.EMISSION_STANDARD_LOAD_CD,
                stn.EMISSION_STANDARD_UOM_CD,
                stu.UOM_CD_DESCRIPTION as EMISSION_STANDARD_UOM_LABEL,
                smm.MODUS_VALUE,
                smm.MODUS_UOM_CD,
                mvu.UOM_CD_DESCRIPTION as MODUS_UOM_LABEL,
                smm.ELECTRICAL_LOAD_CD,
                smm.NO_PERIOD_ENDED_IND,
                smm.NO_PERIOD_ENDED_COMMENT,
                smm.NSPS4T_SUM_ID,
                sel.MON_PLAN_ID,
                sel.RPT_PERIOD_ID,
                sel.MON_LOC_ID
          from  sel
                join camdecmpswks.NSPS4T_SUMMARY smm 
                  on smm.MON_LOC_ID = sel.MON_LOC_ID
                 and smm.RPT_PERIOD_ID = sel.RPT_PERIOD_ID
                join camdecmpswks.MONITOR_LOCATION loc 
                  on loc.MON_LOC_ID = smm.MON_LOC_ID
                left join camd.UNIT unt 
                  on unt.UNIT_ID = loc.UNIT_ID
                left join camdecmpswks.STACK_PIPE stp 
                  on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                join camd.PLANT fac
                  on fac.FAC_ID in (unt.FAC_ID, stp.FAC_ID)
                left join camdecmpsmd.NSPS4T_EMISSION_STANDARD_CODE stn
                  on stn.EMISSION_STANDARD_CD = smm.EMISSION_STANDARD_CD
                left join camdecmpsmd.UNITS_OF_MEASURE_CODE stu
                  on stu.UOM_CD = stn.EMISSION_STANDARD_UOM_CD
                left join camdecmpsmd.UNITS_OF_MEASURE_CODE mvu
                  on mvu.UOM_CD = smm.MODUS_UOM_CD;

END;
$BODY$;
