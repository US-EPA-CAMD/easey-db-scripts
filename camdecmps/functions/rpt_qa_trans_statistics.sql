DROP FUNCTION IF EXISTS camdecmps.rpt_qa_trans_statistics(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_trans_statistics(
	testsumid text)
    RETURNS TABLE("highLevelAccuracy" numeric, "highLevelAccuracySpec" text, "midLevelAccuracy" numeric, "midLevelAccuracySpec" text, "lowLevelAccuracy" numeric, "lowLevelAccuracySpec" text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	high_level_accuracy as "highLevelAccuracy",
	high_level_accuracy_spec_cd as "highLevelAccuracySpec",
	mid_level_accuracy as "midLevelAccuracy",
	mid_level_accuracy_spec_cd as "midLevelAccuracySpec",
	low_level_accuracy as "lowLevelAccuracy",
	low_level_accuracy_spec_cd as "lowLevelAccuracySpec"
	FROM camdecmps.trans_accuracy
	JOIN camdecmps.test_summary ts USING(test_sum_id)
	WHERE ts.test_sum_id = testSumId;
$BODY$;