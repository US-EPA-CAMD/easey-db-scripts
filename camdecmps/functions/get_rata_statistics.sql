-- FUNCTION: camdecmps.get_linearity_statistics(text, text, text)

DROP FUNCTION IF EXISTS camdecmps.get_linearity_statistics(text, text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_rata_statistic(
	testsumid text,
	oplevelcd text,
	row1 text,
	column1 text,
	row2 text,
	column2 text)
    RETURNS TABLE("rowName1" text, "reported1" numeric, "calculated1" numeric, "rowName2" text, "reported2" numeric, "calculated2" numeric) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
DECLARE
	sqlStatement text;
BEGIN
	sqlStatement := format('
		SELECT
			%3$L as "rowName1",
			rs.%4$I as "reported1",
			rs.calc_%4$I as "calculated1",
			%5$L as "rowName2",
			rs.%6$I as "reported2",
			rs.calc_%6$I as "calculated2"
		FROM camdecmps.rata_summary rs
		JOIN camdecmps.rata r USING(rata_id)
		WHERE test_sum_id = %1$L 
		AND op_level_cd = %2$L
	', testsumid, oplevelcd, row1, column1, row2, column2);
	RETURN QUERY EXECUTE sqlStatement;
END;
$BODY$;

CREATE OR REPLACE FUNCTION camdecmps.get_rata_statistics(
	testsumid text,
	oplevelcd text)
    RETURNS TABLE("rowNumber" integer, "rowName1" text, "reported" numeric, "calculated" numeric, "rowName2" text, "reported2" numeric, "calculated2" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT 1 AS "rowNumber", *
	FROM camdecmps.get_rata_statistic(
		testSumId,
		oplevelcd,
		'Mean of Monitoring System',
		'mean_cem_value',
		'Relative Accuracy',
		'relative_accuracy'
  	)
  	UNION
	SELECT 2 AS "rowNumber", *
	FROM camdecmps.get_rata_statistic(
		testSumId,
		oplevelcd,
		'Mean of Reference Method Value',
		'mean_rata_ref_value',
		'Bias Adjustment Factor',
		'bias_adj_factor'
  	)
	UNION
	SELECT 3 AS "rowNumber", *
	FROM camdecmps.get_rata_statistic(
		testSumId,
		oplevelcd,
		'Mean of Difference',
		'mean_diff',
		'APS Indicator',
		'aps_ind'
  	)
	UNION
	SELECT 4 AS "rowNumber", *
	FROM camdecmps.get_rata_statistic(
		testSumId,
		oplevelcd,
		'Standard Deviation of Difference',
		'stnd_dev_diff',
		'T-Value',
		't_value'
  	)
	UNION
	SELECT 5 AS "rowNumber", *
	FROM camdecmps.get_rata_statistic(
		testSumId,
		oplevelcd,
		'Confidence Coefficient',
		'confidence_coef',
		'Gross Unit Load or Velocity',
		'avg_gross_unit_load'
  	)
	ORDER BY "rowNumber";
$BODY$;