-- FUNCTION: camdecmps.rpt_qa_test_summary(text)

DROP FUNCTION IF EXISTS camdecmps.rpt_qa_test_summary(text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_test_summary(
	testsumid text
)
RETURNS TABLE(
	"unitStack" text,
	"testTypeCode" text,
	"testNumber" text,
	"testReasonCode" text, 
	"testResultCode" text,
	"calcTestResultCode" text,
	"spanScaleCode" text,
	"calcSpanValue" numeric,
	"endDateTime" text,
	"systemIdentifier" text,
	"systemTypeCode" text,
	"componentIdentifier" text,
	"componentTypeCode" text
)
LANGUAGE 'sql'
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
		camdecmps.format_date_hour(ts.end_date, ts.end_hour, ts.end_min) AS "endDateTime",
		ms.system_identifier AS "systemIdentifier",
		ms.sys_type_cd AS "systemTypeCode",
		c.component_identifier AS "componentIdentifier",
		c.component_type_cd AS "componentTypeCode"
	FROM camdecmps.test_summary ts
	JOIN camdecmps.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmps.monitor_system ms USING(mon_sys_id)
	LEFT JOIN camdecmps.component c USING(component_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE ts.test_sum_id = testSumId;
$BODY$;
