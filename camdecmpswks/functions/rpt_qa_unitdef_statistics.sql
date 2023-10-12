CREATE OR REPLACE FUNCTION camdecmpswks.rpt_qa_unitdef_statistics(
	testsumid text)
    RETURNS TABLE(
		"fuelType" text,
		"defaultReported" numeric,
		"defaultCalculated" numeric,
		"opCondition" text,
		"identicalId" text,
		"noUnitsGroup" numeric,
		"noTestGroup" numeric
	) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	fuel_cd as "fuelType",
	nox_default_rate as "defaultReported",
	calc_nox_default_rate as "defaultCalculated",
	operating_condition_cd as "opCondition",
	group_id as "identicalId",
	num_units_in_group as "noUnitsGroup",
	num_tests_for_group as "noTestGroup"
	FROM camdecmpswks.unit_default_test
	WHERE test_sum_id = testSumId
	ORDER BY "fuelType";
$BODY$;