DROP FUNCTION IF EXISTS camdecmps.rpt_qa_unitdef_run(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_unitdef_run(
	testsumid text)
    RETURNS TABLE("operatingLevelNo" numeric, "runNo" numeric, "beginDate" text, "endDate" text,  "noxEmissionsRate" numeric, "responseTime" numeric, "runUsed" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	op_level_num as "operatingLevelNo",
	run_num as "runNo",
	camdecmps.format_date_hour(begin_date, begin_hour, begin_min) as "beginDate",
	camdecmps.format_date_hour(end_date, end_hour, end_min) as "endDate",
	ref_value as "noxEmissionsRate",
	response_time as "responseTime",
	run_used_ind as "runUsed"
	FROM camdecmps.unit_default_test_run 
	JOIN camdecmps.unit_default_test using(unit_default_test_sum_id)
	WHERE test_sum_id = testSumId
	ORDER BY "operatingLevelNo", "runNo";
$BODY$;