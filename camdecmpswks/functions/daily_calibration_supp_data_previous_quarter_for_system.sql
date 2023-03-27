-- FUNCTION: camdecmpswks.daily_calibration_supp_data_previous_quarter_for_system(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.daily_calibration_supp_data_previous_quarter_for_system(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.daily_calibration_supp_data_previous_quarter_for_system(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(daily_test_supp_data_id character varying, mon_sys_id character varying, op_hour_cnt numeric, last_covered_nonop_datehour timestamp without time zone, first_op_after_nonop_datehour timestamp without time zone, mon_loc_id character varying, rpt_period_id numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
    quarterOrd  integer;
BEGIN  

    if rptPeriodId IS NULL then
        quarterOrd := NULL;
    else
        select  ( 4 * prd.CALENDAR_YEAR + prd.QUARTER )
          into  quarterOrd
          from  camdecmpsmd.REPORTING_PERIOD prd
         where  prd.RPT_PERIOD_ID = rptPeriodId;
    end if;
		

    RETURN QUERY    
        select  sps.DAILY_TEST_SUPP_DATA_ID,
				sps.MON_SYS_ID,
				sps.OP_HOUR_CNT,
				sps.LAST_COVERED_NONOP_DATEHOUR,
				sps.FIRST_OP_AFTER_NONOP_DATEHOUR,
				sps.MON_LOC_ID,
				sps.RPT_PERIOD_ID
          from  (
                    -- Get the maximumn Quarter Ord for each combination of component-systems, span scale, online ind, and valid ind.
                    select  lst.COMPONENT_ID,
                            lst.TEST_TYPE_CD,
                            lst.MON_SYS_ID,
                            lst.SPAN_SCALE_CD,
                            lst.KEY_ONLINE_IND,
                            lst.KEY_VALID_IND,
                            MAX( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) as MAX_QUARTER_ORD
                      from  (
                                -- Return all possible combinations of component-systems, span scale, online ind, and valid ind.
                                select  cid.COMPONENT_ID,
                                        cid.TEST_TYPE_CD,
                                        cid.MON_SYS_ID,
                                        ssc.SPAN_SCALE_CD,
                                        koi.KEY_ONLINE_IND,
                                        kvi.KEY_VALID_IND
                                  from  (
                                            -- Get list of component-system ids in supp date for quarter on or before the quarter of the emissions report.
                                            select  sup.COMPONENT_ID,
                                                    sup.TEST_TYPE_CD,
                                                    sps.MON_SYS_ID
                                              from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                                                    join camdecmpswks.DAILY_TEST_SUPP_DATA sup
                                                      on sup.MON_LOC_ID = mpl.MON_LOC_ID
                                                     and sup.TEST_TYPE_CD = 'DAYCAL'
                                                    join camdecmpsmd.REPORTING_PERIOD prd
                                                      on ( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) <= quarterOrd
                                                    join camdecmpswks.DAILY_TEST_SYSTEM_SUPP_DATA sps
                                                      on sps.DAILY_TEST_SUPP_DATA_ID = sup.DAILY_TEST_SUPP_DATA_ID
                                             where  ( monPlanId is null or mpl.MON_PLAN_ID = monPlanId )
                                             group
                                                by  sup.COMPONENT_ID,
                                                    sup.TEST_TYPE_CD,
                                                    sps.MON_SYS_ID
                                        ) cid,
                                        ( select 'H' as SPAN_SCALE_CD union all select 'L' as SPAN_SCALE_CD ) ssc,
                                        ( select 0 as KEY_ONLINE_IND union all select 1 as KEY_ONLINE_IND ) koi,
                                        ( select 0 as KEY_VALID_IND union all select 1 as KEY_VALID_IND ) kvi
                            ) lst
                            join camdecmpswks.DAILY_TEST_SUPP_DATA sup 
                              on sup.COMPONENT_ID = lst.COMPONENT_ID 
                             and sup.TEST_TYPE_CD = lst.TEST_TYPE_CD
                             and sup.SPAN_SCALE_CD = lst.SPAN_SCALE_CD
                             and sup.KEY_ONLINE_IND = lst.KEY_ONLINE_IND
                             and sup.KEY_VALID_IND = lst.KEY_VALID_IND
                            join camdecmpsmd.REPORTING_PERIOD prd
                              on prd.RPT_PERIOD_ID = sup.RPT_PERIOD_ID
                             and ( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) < quarterOrd -- Limit supp data returned to previous quarters
                            join camdecmpswks.DAILY_TEST_SYSTEM_SUPP_DATA sps
                              on sps.DAILY_TEST_SUPP_DATA_ID = sup.DAILY_TEST_SUPP_DATA_ID
                             and sps.MON_SYS_ID = lst.MON_SYS_ID
                     group
                        by  lst.COMPONENT_ID,
                            lst.TEST_TYPE_CD,
                            lst.MON_SYS_ID,
                            lst.SPAN_SCALE_CD,
                            lst.KEY_ONLINE_IND,
                            lst.KEY_VALID_IND
                ) sel
                join camdecmpsmd.REPORTING_PERIOD prd
                  on ( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) = sel.MAX_QUARTER_ORD -- Select the maximum quarter
                join camdecmpswks.DAILY_TEST_SUPP_DATA sup 
                  on sup.COMPONENT_ID = sel.COMPONENT_ID 
                 and sup.RPT_PERIOD_ID = prd.RPT_PERIOD_ID
                 and sup.TEST_TYPE_CD = sel.TEST_TYPE_CD
                 and sup.SPAN_SCALE_CD = sel.SPAN_SCALE_CD
                 and sup.KEY_ONLINE_IND = sel.KEY_ONLINE_IND
                 and sup.KEY_VALID_IND = sel.KEY_VALID_IND
				join camdecmpswks.COMPONENT cmp ON cmp.COMPONENT_ID = sup.COMPONENT_ID
                join camdecmpswks.DAILY_TEST_SYSTEM_SUPP_DATA sps
                    on sps.DAILY_TEST_SUPP_DATA_ID = sup.DAILY_TEST_SUPP_DATA_ID
                    and sps.MON_SYS_ID = sel.MON_SYS_ID
                join camdecmpswks.MONITOR_LOCATION loc on loc.MON_LOC_ID = cmp.MON_LOC_ID
                left join camd.UNIT unt on unt.UNIT_ID = loc.UNIT_ID
                left join camdecmpswks.STACK_PIPE stp on stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
                join camd.PLANT fac on fac.FAC_ID in ( unt.FAC_ID, stp.FAC_ID );

END;
$BODY$;
