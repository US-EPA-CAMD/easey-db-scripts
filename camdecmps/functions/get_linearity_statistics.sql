-- FUNCTION: camdecmps.get_linearity_statistics(text, text, text)

DROP FUNCTION IF EXISTS camdecmps.get_linearity_statistics(text, text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_linearity_statistics(
	testsumid text,
	tablename text,
	columnname text)
    RETURNS TABLE("rowName" text, "highReportedValue" numeric, "highCalculatedValue" numeric, "midReportedValue" numeric, "midCalculatedValue" numeric, "lowReportedValue" numeric, "lowCalculatedValue" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT
		CASE
			WHEN columnName = 'mean_ref_value' THEN 'Reference Value'
			WHEN columnName = 'mean_measured_value' THEN 'Mass CEM Value'
			WHEN columnName = 'aps_ind' THEN 'Alt. Perf. Indicator'
			WHEN columnName = 'percent_error' THEN 'Results'
		END AS "rowName",
		high.reported_value AS "highReportedValue",
		high.calculated_value AS "highCalculatedValue",
		mid.reported_value AS "midReportedValue",
		mid.calculated_value AS "midCalculatedValue",
		low.reported_value AS "lowReportedValue",
		low.calculated_value AS "lowCalculatedValue"
	FROM camdecmps.get_linearity_statistic(
		testSumId,
		'HIGH',
		tableName,
		columnName
	) AS high
	JOIN camdecmps.get_linearity_statistic(
		testSumId,
		'MID',
		tableName,
		columnName
	) AS mid USING(test_sum_id)
	JOIN camdecmps.get_linearity_statistic(
		testSumId,
		'LOW',
		tableName,
		columnName
	) AS low USING(test_sum_id)
$BODY$;

-- FUNCTION: camdecmps.get_linearity_statistics(text, text)

DROP FUNCTION IF EXISTS camdecmps.get_linearity_statistics(text, text) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_linearity_statistics(
	testsumid text,
	tablename text)
    RETURNS TABLE("rowNumber" integer, "rowName" text, "highReportedValue" numeric, "highCalculatedValue" numeric, "midReportedValue" numeric, "midCalculatedValue" numeric, "lowReportedValue" numeric, "lowCalculatedValue" numeric) 
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
SELECT 1 AS "rowNumber", *
	FROM camdecmps.get_linearity_statistics(
		testSumId,
		tableName,
		'mean_ref_value'
  	)
  	UNION
	SELECT 2 AS "rowNumber", *
	FROM camdecmps.get_linearity_statistics(
		testSumId,
		tableName,
		'mean_measured_value'
	)
	UNION
	SELECT 3 AS "rowNumber", *
	FROM camdecmps.get_linearity_statistics(
		testSumId,
		tableName,
		'aps_ind'
	)
	UNION
	SELECT 4 AS "rowNumber", *
	FROM camdecmps.get_linearity_statistics(
		testSumId,
		tableName,
		'percent_error'
	)
	ORDER BY "rowNumber";
$BODY$;
