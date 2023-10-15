CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ae_testing(
	testsumid text)
    RETURNS TABLE(		
		"qIName" text,
		"examDate" text,
		"providerName" text,
		"providerEmail" text,
		"aetbName" text,
		"aetbPhone" text,
		"aetbEmail" text) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	qi_first_name || ' ' || qi_middle_initial || '. ' || qi_last_name AS "qIName",
	TO_CHAR(exam_date, 'YYYY-MM-DD') AS "examDate",
	provider_name AS "providerName",
	provider_email AS "providerEmail",
	aetb_name AS "aetbName",
	aetb_phone_number AS "aetbPhone",
	aetb_email AS "aetbEmail"
	FROM camdecmps.air_emission_testing
	WHERE test_sum_id = testSumId;
$BODY$;