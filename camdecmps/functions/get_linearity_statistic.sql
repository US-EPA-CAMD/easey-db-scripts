-- FUNCTION: camdecmps.get_linearity_statistic(text, text, text, text)

DROP FUNCTION IF EXISTS camdecmps.get_linearity_statistic(text, text, text, text);

CREATE OR REPLACE FUNCTION camdecmps.get_linearity_statistic(
	testsumid text,
	gaslevelcode text,
	tablename text,
	columnname text)
    RETURNS TABLE(test_sum_id character varying, reported_value numeric, calculated_value numeric) 
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
			test_sum_id,
			%s AS reported_value,
			calc_%s AS calculated_value
		FROM camdecmps.%s
		JOIN camdecmps.test_summary USING(test_sum_id)
		WHERE test_sum_id = %L
		AND gas_level_cd = %L
	', columnName, columnName, tableName, testSumId, gasLevelCode);
	RETURN QUERY EXECUTE sqlStatement;
END;
$BODY$;