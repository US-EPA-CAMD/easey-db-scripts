-- FUNCTION: camdecmpswks.daily_interference_supp_data_previous_quarter(character varying, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.daily_interference_supp_data_previous_quarter(character varying, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.daily_interference_supp_data_previous_quarter(
	monplanid character varying,
	rptperiodid numeric)
    RETURNS TABLE(component_id character varying, component_identifier character varying, test_type_cd character varying, key_online_ind numeric, key_valid_ind numeric, op_hour_cnt numeric, last_covered_nonop_datehour timestamp without time zone, first_op_after_nonop_datehour timestamp without time zone, test_result_cd character varying, calc_test_result_cd character varying, daily_test_date date, daily_test_hour numeric, daily_test_min numeric, daily_test_datehour timestamp without time zone, daily_test_sum_id character varying, mon_loc_id character varying, rpt_period_id numeric, daily_test_supp_data_id character varying) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN  
    RETURN QUERY    
        select  sup.COMPONENT_ID,
                cmp.COMPONENT_IDENTIFIER,
                sup.TEST_TYPE_CD,
                sup.KEY_ONLINE_IND,
                sup.KEY_VALID_IND,
                sup.OP_HOUR_CNT,
                sup.LAST_COVERED_NONOP_DATEHOUR,
                sup.FIRST_OP_AFTER_NONOP_DATEHOUR,
                sup.TEST_RESULT_CD,
                sup.CALC_TEST_RESULT_CD,
                sup.DAILY_TEST_DATEHOURMIN::date as DAILY_TEST_DATE,
                date_part( 'hour', sup.DAILY_TEST_DATEHOURMIN )::numeric as DAILY_TEST_HOUR,
                date_part( 'minute', sup.DAILY_TEST_DATEHOURMIN )::numeric as DAILY_TEST_MIN,
                date_trunc( 'hour', sup.DAILY_TEST_DATEHOURMIN ) as DAILY_TEST_DATEHOUR,
                sup.DAILY_TEST_SUM_ID,
                sup.MON_LOC_ID,
                sup.RPT_PERIOD_ID,
                sup.DAILY_TEST_SUPP_DATA_ID
          from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
                JOIN camdecmpswks.DAILY_TEST_SUPP_DATA sup on sup.MON_LOC_ID = mpl.MON_LOC_ID and sup.TEST_TYPE_CD = 'INTCHK'
                JOIN camdecmpswks.COMPONENT cmp on cmp.COMPONENT_ID = sup.COMPONENT_ID
         where  ( monPlanId IS NULL OR mpl.MON_PLAN_ID = monPlanId )
           and  (
                    rptPeriodId IS NULL 
                    or
                    exists
                    (
                        select  prv.RPT_PERIOD_ID
                          from  camdecmpsmd.REPORTING_PERIOD cur
                                left join camdecmpsmd.REPORTING_PERIOD prv on ( 4 * prv.CALENDAR_YEAR + prv.QUARTER ) = ( 4 * cur.CALENDAR_YEAR + cur.QUARTER ) - 1
                         where  cur.RPT_PERIOD_ID = rptPeriodId
                           and  prv.RPT_PERIOD_ID = sup.RPT_PERIOD_ID
                    )
                );

END;
$BODY$;
