-- FUNCTION: camdecmpswks.rpt_qa_linearity_statistics(text)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_linearity_statistics(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_linearity_statistics(
	testsumid text)
    RETURNS TABLE("unitStack" text, "rowName" text, "highReportedValue" numeric, "highCalculatedValue" numeric, "midReportedValue" numeric, "midCalculatedValue" numeric, "lowReportedValue" numeric, "lowCalculatedValue" numeric) 
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
		"rowName",
		"highReportedValue",
		"highCalculatedValue",
		"midReportedValue",
		"midCalculatedValue",
		"lowReportedValue",
		"lowCalculatedValue"
	FROM camdecmpswks.get_linearity_statistics(
		testSumId,
		'linearity_summary'
	), camdecmpswks.test_summary
	JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.unit u USING(unit_id)
	WHERE test_sum_id = testSumId
	ORDER BY "rowNumber";
$BODY$;
