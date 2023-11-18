DROP FUNCTION IF EXISTS camdecmps.rpt_qa_rata_run(text,text);

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_rata_run(
	testsumid text,
	oplevelcd text)
    RETURNS TABLE(
		"run" numeric,
		"startDate" text,
		"endDate" text,
		"runStatus" text,
		"monSysValue" numeric,
		"refMethodValue" numeric,
		"grossLoadOrVel" numeric
		) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	rr.run_num as "run",
	camdecmps.format_date_hour(rr.begin_date, rr.begin_hour, rr.begin_min) as "startDate",
	camdecmps.format_date_hour(rr.end_date, rr.end_hour, rr.end_min) as "endDate",
	rr.run_status_cd as "runStatus",
	rr.cem_value as "monSysValue",
	rr.rata_ref_value as "refMethodValue",
	rr.gross_unit_load as "grossLoadOrVel"
	FROM camdecmps.rata_run rr
	join camdecmps.rata_summary rs using(rata_sum_id)
	join camdecmps.rata r using(rata_id)
	WHERE test_sum_id = testSumId
	AND rs.op_level_cd = oplevelcd
	ORDER BY "run";
$BODY$;