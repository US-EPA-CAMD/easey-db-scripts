CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_ffacc(
	testsumid text)
    RETURNS TABLE(
		"accMethod" text,
		"highAcc" numeric,
		"midAcc" numeric,
		"lowAcc" numeric,
		"reinstall" text
		) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	acc.acc_test_method_cd AS "testBasis",
	acc.high_fuel_accuracy AS "avgPctDiff",
	acc.mid_fuel_accuracy AS "hoursUsed",
	acc.low_fuel_accuracy AS "coFire",
	camdecmpswks.format_date_hour(acc.reinstall_date, acc.reinstall_hour, null) AS "reinstall"
	FROM camdecmpswks.fuel_flowmeter_accuracy acc
	WHERE acc.test_sum_id = testSumId;
$BODY$;