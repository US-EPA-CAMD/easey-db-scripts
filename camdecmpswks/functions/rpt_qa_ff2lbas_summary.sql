-- FUNCTION: camdecmpswks.rpt_qa_test_summary(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_ffl2bas_summary(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_ffl2bas_summary(
	testsumid text)
    RETURNS TABLE("unitStack" text, "gpIndicator" numeric, "testTypeCode" text, "testNumber" text, "testReasonCode" text, "testResultCode" text, "calcTestResultCode" text, "spanScaleCode" text, "calcSpanValue" numeric, "beginDateTime" text ,"endDateTime" text, "systemIdentifier" text, "systemTypeCode" text, "componentIdentifier" text, "componentTypeCode" text, "quarter" text, 
	"accNum" text, "peiTestNum" text
	) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
		CASE
			WHEN ml.stack_pipe_id IS NOT NULL THEN sp.stack_name
			WHEN ml.unit_id IS NOT NULL THEN u.unitid
			ELSE '*'
		END AS "unitStack",
		ts.gp_ind as "gpIndicator",
		ts.test_type_cd AS "testTypeCode",
		ts.test_num AS "testNumber",
		ts.test_reason_cd AS "testReasonCode",
		ts.test_result_cd AS "testResultCode",
		ts.calc_test_result_cd AS "calcTestResultCode",	
		ts.span_scale_cd AS "spanScaleCode",
		ts.calc_span_value AS "calcSpanValue",
		camdecmpswks.format_date_hour(ts.begin_date, ts.begin_hour, ts.begin_min) AS "beginDateTime",
		camdecmpswks.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS "endDateTime",
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode",
		rp.period_abbreviation as "quarter",
		ffl2b.accuracy_test_number as "accTestNum",
		ffl2b.pei_test_number as "peiTestNum"
	FROM camdecmpswks.test_summary ts
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	JOIN camdecmpswks.fuel_flow_to_load_baseline ffl2b using(test_sum_id)
	LEFT JOIN camdecmpsmd.reporting_period rp USING(rpt_period_id)
	LEFT JOIN camdecmpswks.monitor_system ms USING(mon_sys_id)
	LEFT JOIN camdecmpswks.component c USING(component_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE ts.test_sum_id = testSumId;
$BODY$;