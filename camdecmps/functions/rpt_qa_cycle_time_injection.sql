-- FUNCTION: camdecmps.rpt_qa_cycle_time_injection(text)

DROP FUNCTION IF EXISTS camdecmps.rpt_qa_cycle_time_injection(text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_cycle_time_injection(
	testsumid text)
    RETURNS TABLE("unitStack" text, date text, "startTime" text, "endTime" text, "gasLevelCode" text, "gasValue" numeric, "beginMonitorValue" numeric, "endMonitorValue" numeric, "rptCycleTime" numeric, "calcCycleTime" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		camdecmps.format_date_hour(cti.begin_date, null, null) AS "date",
		camdecmps.format_time(cti.begin_hour, cti.begin_min) AS "startTime",
		camdecmps.format_time(cti.begin_hour, cti.begin_min) AS "endTime",
		cti.gas_level_cd AS "gasLevelCode",
		cti.cal_gas_value AS "gasValue",
		cti.begin_monitor_value AS "beginMonitorValue",
		cti.end_monitor_value AS "endMonitorValue",
		cti.injection_cycle_time AS "rptCycleTime",
		cti.calc_injection_cycle_time AS "calcCycleTime"
	FROM camdecmps.cycle_time_injection cti
	JOIN camdecmps.cycle_time_summary cts USING(cycle_time_sum_id)
	JOIN camdecmps.test_summary ts USING(test_sum_id)
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE test_sum_id = testSumId;
$BODY$;
