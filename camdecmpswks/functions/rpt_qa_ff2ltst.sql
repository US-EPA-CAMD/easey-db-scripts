CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_ff2ltst(
	testsumid text)
    RETURNS TABLE(
		"testBasis" text,
		"avgPctDiff" numeric,
		"hoursUsed" numeric,
		"coFire" numeric,
		"ramping" numeric,
		"lowRange" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	tst.test_basis_cd AS "testBasis",
	tst.avg_diff AS "avgPctDiff",
	tst.num_hrs AS "hoursUsed",
	tst.nhe_cofiring AS "coFire",
	tst.nhe_ramping AS "ramping",
	tst.nhe_low_range AS "lowRange"
	FROM camdecmpswks.fuel_flow_to_load_check tst
	WHERE tst.test_sum_id = testSumId;
$BODY$;