-- FUNCTION: camdecmpswks.daily_miscellaneous_test_period_data(character varying, date, date)

DROP FUNCTION IF EXISTS camdecmpswks.daily_miscellaneous_test_period_data(character varying, date, date) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.daily_miscellaneous_test_period_data(
	monplanid character varying,
	evalperiodbegandate date,
	evalperiodendeddate date)
    RETURNS TABLE(daily_test_sum_id character varying, mon_plan_id character varying, rpt_period_id numeric, oris_code numeric, location_name character varying, test_type_cd character varying, daily_test_date date, daily_test_hour numeric, daily_test_min numeric, daily_test_datetime timestamp without time zone, daily_test_datehour timestamp without time zone, mon_sys_id character varying, system_identifier character varying, sys_type_cd character varying, component_id character varying, component_identifier character varying, component_type_cd character varying, span_scale_cd character varying, test_result_cd character varying, calc_test_result_cd character varying, mon_loc_id character varying, fac_id numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
     RETURN QUERY
     SELECT dts.DAILY_TEST_SUM_ID,  
			mpl.MON_PLAN_ID,
			dts.RPT_PERIOD_ID,
			fac.ORIS_CODE,
			CASE
				WHEN unt.UNIT_ID IS NOT NULL THEN unt.UNITID
				WHEN stp.STACK_PIPE_ID IS NOT NULL THEN stp.STACK_NAME
				ELSE NULL
			END AS LOCATION_NAME, 
			dts.TEST_TYPE_CD,  
			dts.DAILY_TEST_DATE,  
			dts.DAILY_TEST_HOUR,  
			dts.DAILY_TEST_MIN,  
	camdecmpswks.Format_Date_Time(dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, dts.DAILY_TEST_MIN) DAILY_TEST_DATETIME,
	camdecmpswks.Format_Date_Time(dts.DAILY_TEST_DATE, dts.DAILY_TEST_HOUR, 0) DAILY_TEST_DATEHOUR,
			dts.MON_SYS_ID,
			sys.SYSTEM_IDENTIFIER,
			sys.SYS_TYPE_CD,
			dts.COMPONENT_ID,  
			cmp.COMPONENT_IDENTIFIER,  
			cmp.COMPONENT_TYPE_CD,  
			dts.SPAN_SCALE_CD,  
			dts.TEST_RESULT_CD, 
			dts.CALC_TEST_RESULT_CD,
			dts.MON_LOC_ID,
			fac.FAC_ID  
		FROM	(select	monPlanid MON_PLAN_ID,
					evalPeriodBeganDate EVAL_PERIOD_BEGAN_DATE,
					evalPeriodEndedDate EVAL_PERIOD_ENDED_DATE) lst
				INNER JOIN camdecmpswks.MONITOR_PLAN_LOCATION mpl
					ON (mpl.MON_PLAN_ID = lst.MON_PLAN_ID or lst.MON_PLAN_ID is null)
				INNER JOIN camdecmpswks.MONITOR_LOCATION loc
					ON loc.MON_LOC_ID = mpl.MON_LOC_ID
				LEFT OUTER JOIN camd.UNIT unt
					ON unt.UNIT_ID = loc.UNIT_ID
				LEFT OUTER JOIN camdecmpswks.STACK_PIPE stp
					ON stp.STACK_PIPE_ID = loc.STACK_PIPE_ID
				INNER JOIN camd.plant fac
					ON fac.FAC_ID in (unt.FAC_ID, stp.FAC_ID)
				INNER JOIN camdecmpswks.DAILY_TEST_SUMMARY dts
					ON dts.MON_LOC_ID = loc.MON_LOC_ID 
					   and dts.TEST_TYPE_CD != 'DAYCAL'
					   and (dts.DAILY_TEST_DATE >= lst.EVAL_PERIOD_BEGAN_DATE or
					        lst.EVAL_PERIOD_BEGAN_DATE is null)
					   and (dts.DAILY_TEST_DATE <= lst.EVAL_PERIOD_ENDED_DATE or
					        lst.EVAL_PERIOD_ENDED_DATE is null)
				LEFT OUTER JOIN camdecmpswks.MONITOR_SYSTEM sys 
					ON sys.MON_SYS_ID = dts.MON_SYS_ID
				LEFT OUTER JOIN camdecmpswks.COMPONENT cmp 
					ON cmp.COMPONENT_ID = dts.COMPONENT_ID;

END;
$BODY$;
