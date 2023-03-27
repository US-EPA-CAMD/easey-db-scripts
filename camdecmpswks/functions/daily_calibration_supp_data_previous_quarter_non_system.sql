-- FUNCTION: camdecmpswks.daily_calibration_supp_data_previous_quarter_non_system(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.daily_calibration_supp_data_previous_quarter_non_system(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.daily_calibration_supp_data_previous_quarter_non_system(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(component_id character varying, component_identifier character varying, test_type_cd character varying, span_scale_cd character varying, key_online_ind numeric, key_valid_ind numeric, op_hour_cnt numeric, last_covered_nonop_datehour timestamp without time zone, first_op_after_nonop_datehour timestamp without time zone, daily_test_datehourmin timestamp without time zone, daily_test_date date, daily_test_hour numeric, daily_test_min numeric, formatted_test_date character varying, test_result_cd character varying, online_offline_ind numeric, sort_daily_test_datehourmin timestamp without time zone, calc_test_result_cd character varying, daily_test_sum_id character varying, mon_loc_id character varying, rpt_period_id numeric, daily_test_supp_data_id character varying) 
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
		select	sup.COMPONENT_ID,
				cmp.COMPONENT_IDENTIFIER,
				sup.TEST_TYPE_CD,
				CASE WHEN sup.SPAN_SCALE_CD = 'N' THEN NULL ELSE sup.SPAN_SCALE_CD END AS SPAN_SCALE_CD,
				sup.KEY_ONLINE_IND,
				sup.KEY_VALID_IND,
				sup.OP_HOUR_CNT,
				sup.LAST_COVERED_NONOP_DATEHOUR,
				sup.FIRST_OP_AFTER_NONOP_DATEHOUR,
				sup.DAILY_TEST_DATEHOURMIN,
				sup.DAILY_TEST_DATEHOURMIN::date AS DAILY_TEST_DATE,
				date_part('hour', sup.DAILY_TEST_DATEHOURMIN)::numeric AS DAILY_TEST_HOUR,
				date_part('minute', sup.DAILY_TEST_DATEHOURMIN)::numeric AS DAILY_TEST_MIN,
                to_char( sup.DAILY_TEST_DATEHOURMIN, 'MM/DD/YYYY at HH24:MI')::varchar as FORMATTED_TEST_DATE,
				sup.TEST_RESULT_CD,
				sup.ONLINE_OFFLINE_IND,
				sup.SORT_DAILY_TEST_DATEHOURMIN,
				sup.CALC_TEST_RESULT_CD,
				sup.DAILY_TEST_SUM_ID,
				sup.MON_LOC_ID,
				sup.RPT_PERIOD_ID,
				sup.DAILY_TEST_SUPP_DATA_ID
          from  (
                    -- Get the maximumn Quarter Ord for each combination of components, span scale, online ind, and valid ind.
                    select  lst.COMPONENT_ID,
                            lst.TEST_TYPE_CD,
                            lst.SPAN_SCALE_CD,
                            lst.KEY_ONLINE_IND,
                            lst.KEY_VALID_IND,
                            MAX( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) as MAX_QUARTER_ORD
                      from  (
                                -- Return all possible combinations of components, span scale, online ind, and valid ind.
                                select  cid.COMPONENT_ID,
                                        cid.TEST_TYPE_CD,
                                        ssc.SPAN_SCALE_CD,
                                        koi.KEY_ONLINE_IND,
                                        kvi.KEY_VALID_IND
                                  from  (
                                            -- Get list of component ids in supp date for quarter on or before the quarter of the emissions report.
                                            select  sup.COMPONENT_ID,
                                                    sup.TEST_TYPE_CD
                                              from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                                                    join camdecmpswks.DAILY_TEST_SUPP_DATA sup
                                                      on sup.MON_LOC_ID = mpl.MON_LOC_ID
                                                     and sup.TEST_TYPE_CD = 'DAYCAL'
                                                    join camdecmpsmd.REPORTING_PERIOD prd
                                                      on ( quarterOrd is null or ( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) <= quarterOrd )
                                             where  ( monPlanId is null or mpl.MON_PLAN_ID = monPlanId )
                                             group
                                                by  sup.COMPONENT_ID,
                                                    sup.TEST_TYPE_CD
                                        ) cid,
                                        ( select 'H' as SPAN_SCALE_CD union all select 'L' as SPAN_SCALE_CD union all select 'N' as SPAN_SCALE_CD ) ssc,
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
                             and ( quarterOrd is null or ( 4 * prd.CALENDAR_YEAR + prd.QUARTER ) < quarterOrd ) -- Limit supp data returned to previous quarters
                     group
                        by  lst.COMPONENT_ID,
                            lst.TEST_TYPE_CD,
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
				join camdecmpswks.COMPONENT cmp ON cmp.COMPONENT_ID = sup.COMPONENT_ID;

END;
$BODY$;
