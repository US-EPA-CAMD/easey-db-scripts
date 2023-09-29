-- FUNCTION: camdecmpswks.rpt_qa_linearity_injection(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_linearity_injection(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_linearity_injection(
	testsumid text)
    RETURNS TABLE("unitStack" text, date text, "gasLevelCode" text, "measuredValue" numeric, "referenceValue" numeric, "refAsPercentOfSpan" text) 
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
		camdecmpswks.format_date_hour(li.injection_date, li.injection_hour, li.injection_min) AS "date",
		ls.gas_level_cd AS "gasLevelCode",
		li.measured_value AS "measuredValue",
		li.ref_value AS "referenceValue",
		ROUND(((li.ref_value / ts.calc_span_value) * 100)::numeric, 1) || '%' AS "refAsPercentOfSpan"
	FROM camdecmpswks.linearity_injection li
	JOIN camdecmpswks.linearity_summary ls USING(lin_sum_id)
	JOIN camdecmpswks.test_summary ts USING(test_sum_id)
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE ts.test_sum_id = testSumId
	ORDER BY ls.gas_level_cd, li.injection_date, li.injection_hour, li.injection_min;
$BODY$;
