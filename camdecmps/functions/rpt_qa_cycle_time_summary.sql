-- FUNCTION: camdecmps.rpt_qa_cycle_time_summary(text)

DROP FUNCTION IF EXISTS camdecmps.rpt_qa_cycle_time_summary(text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_cycle_time_summary(
	testsumid text)
    RETURNS TABLE("unitStack" text, "testTypeCode" text, "testNumber" text, "testReasonCode" text, "testResultCode" text, "calcTestResultCode" text, "spanScaleCode" text, "calcSpanValue" numeric, "endDateTime" text, "componentIdentifier" text, "componentTypeCode" text, "totalCycleTime" numeric, "calcTotalCycleTime" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		"unitStack",
		"testTypeCode",
		"testNumber",
		"testReasonCode",
		"testResultCode",
		"calcTestResultCode",	
		"spanScaleCode",
		"calcSpanValue",
		"endDateTime",
		"componentIdentifier",
		"componentTypeCode",
		cts.total_time AS "totalCycleTime",
		cts.calc_total_time AS "calcTotalCycleTime"
	FROM camdecmps.cycle_time_summary cts,
		 camdecmps.rpt_qa_test_summary(testSumId)
	WHERE cts.test_sum_id = testSumId
$BODY$;
