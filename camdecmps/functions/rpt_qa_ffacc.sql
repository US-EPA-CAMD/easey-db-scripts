DROP FUNCTION IF EXISTS camdecmps.rpt_qa_ffacc(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ffacc(
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
	acc.acc_test_method_cd AS "accMethod",
	acc.high_fuel_accuracy AS "highAcc",
	acc.mid_fuel_accuracy AS "midAcc",
	acc.low_fuel_accuracy AS "lowAcc",
	camdecmps.format_date_hour(acc.reinstall_date, acc.reinstall_hour, null) AS "reinstall"
	FROM camdecmps.fuel_flowmeter_accuracy acc
	WHERE acc.test_sum_id = testSumId;
$BODY$;