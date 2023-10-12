-- FUNCTION: camdecmpswks.rpt_qa_cycle_time_summary(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_cycle_time_summary(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_cycle_time_summary(
	testsumid text)
    RETURNS TABLE("unitStack" text, "testTypeCode" text, "testNumber" text, "testReasonCode" text, "testResultCode" text, "calcTestResultCode" text, "spanScaleCode" text, "calcSpanValue" numeric, "endDateTime" text, "componentIdentifier" text, "componentTypeCode" text, "totalCycleTime" numeric, "calcTotalCycleTime" numeric, "evalStatus" text, "submissionStatus" text, "submittedOn" text) 
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
		ts.test_type_cd AS "testTypeCode",
		ts.test_num AS "testNumber",
		ts.test_reason_cd AS "testReasonCode",
		ts.test_result_cd AS "testResultCode",
		ts.calc_test_result_cd AS "calcTestResultCode",	
		ts.span_scale_cd AS "spanScaleCode",
		ts.calc_span_value AS "calcSpanValue",
		camdecmpswks.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS "endDateTime",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		cts.total_time AS "totalCycleTime",
		cts.calc_total_time AS "calcTotalCycleTime",
		esc.eval_status_cd_description as "evalStatus",
		sac.sub_avail_cd_description as "submisionStatus",
		TO_CHAR(eq.submitted_on, 'MM/DD/YYYY HH24:MI') as "submittedOn"
	FROM camdecmpswks.cycle_time_summary cts
	JOIN camdecmpswks.test_summary ts USING(test_sum_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpswks.monitor_system ms USING(mon_sys_id)
	LEFT JOIN camdecmpswks.component c USING(component_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE cts.test_sum_id = testSumId
$BODY$;
