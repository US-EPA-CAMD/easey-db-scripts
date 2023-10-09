CREATE OR REPLACE FUNCTION camdecmps.rpt_qa_ae_statistics(
	testsumid text)
    RETURNS TABLE("operatingLevelNo" numeric, "fFactor" numeric, "reportedMeanNoxRate" numeric, "reportedAvgHiRate" numeric,  "reportedCaclMeanNoxRate" numeric, "reportedCalcAvgHiRate" numeric) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT
	op_level_num as "operatingLevelNo",
	f_factor as "fFactor",
	mean_ref_value as "reportedMeanNoxRate",
	avg_hrly_hi_rate as "reportedAvgHiRate",
	calc_mean_ref_value as "reportedCaclMeanNoxRate",
	calc_avg_hrly_hi_rate as "reportedCalcAvgHiRate"
	FROM camdecmps.ae_correlation_test_sum
	WHERE test_sum_id = testSumId
	ORDER BY "operatingLevelNo";
$BODY$;