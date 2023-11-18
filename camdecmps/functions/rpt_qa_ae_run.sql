DROP FUNCTION IF EXISTS camdecmps.rpt_qa_ae_run(text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ae_run(
	testsumid text)
    RETURNS TABLE("operatingLevelNo" numeric, "runNo" numeric, "beginDate" text, "endDate" text,  "noxEmissionsRate" numeric, "responseTime" numeric, "hourlyHiRate" numeric, "totalHi" numeric, "calculatedHourlyHiRate" numeric, "calculatedTotalHi" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	ts.op_level_num as "operatingLevelNo",
	tr.run_num as "runNo",
	camdecmps.format_date_hour(tr.begin_date, tr.begin_hour, tr.begin_min) as "beginDate",
	camdecmps.format_date_hour(tr.end_date, tr.end_hour, tr.end_min) as "endDate",
	ref_value as "noxEmissionsRate",
	response_time as "responseTime",
	hourly_hi_rate as "hourlyHiRate",
	total_hi as "totalHi",
	calc_hourly_hi_rate as "calculatedHourlyHiRate",
	calc_total_hi as "calculatedTotalHi"
	FROM camdecmps.ae_correlation_test_run tr
	join camdecmps.ae_correlation_test_sum ts using(ae_corr_test_sum_id)
	WHERE test_sum_id = testSumId
	ORDER BY "operatingLevelNo", "runNo";
$BODY$;