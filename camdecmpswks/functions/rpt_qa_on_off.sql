DROP FUNCTION IF EXISTS camdecmpswks.rpt_qa_on_off(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_on_off(
	testsumid text)
    RETURNS TABLE(
		"calType" text,
		"injectionDateHour" text,
		"gasLevel" text,
		"refValue" numeric,
		"refValuePct" numeric,
		"measuredValue" numeric,
		"results" numeric,
		"APS" numeric,
		"calcResults" numeric,
		"calcAPS" numeric
		) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	"calType",
	camdecmpswks.format_date_hour(acc.reinstall_date, acc.reinstall_hour, null) AS "injectionDateHour",
	"gasLevel",
	"refValue",
	"refValuePct",
	"measuredValue",
	"results",
	"APS",
	"calcResults",
	"calcAPS"
	FROM camdecmpswks.fuel_flowmeter_accuracy acc
	WHERE acc.test_sum_id = testSumId;
$BODY$;