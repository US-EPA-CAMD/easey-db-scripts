DROP PROCEDURE IF EXISTS camdaux.manage_partitions_by_rpt_period_id(text,text,integer);

CREATE OR REPLACE PROCEDURE camdaux.manage_partitions_by_rpt_period_id(
	schemaName text,
	tableName text,
	maxYear integer
) LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	rp record;
	tbl record;
	rptPeriodId numeric;
	sqlStatement text;
	correctTableName text;
BEGIN
	SELECT MAX(d.to_value)
	FROM (
		SELECT to_value::numeric
		FROM camdaux.get_partition_info(schemaName, tableName)
	) AS d INTO rptPeriodId;
	
	FOR rp IN (
		SELECT rpt_period_id, calendar_year, quarter
		FROM camdecmpsmd.reporting_period
		WHERE rpt_period_id >= rptPeriodId AND
		calendar_year <= maxYear
	) LOOP
		sqlStatement := format('
			CREATE TABLE IF NOT EXISTS %s.%s_%s_q%s PARTITION OF %s.%s
				FOR VALUES FROM (%s) TO (%s);
		', schemaName, tableName, rp.calendar_year, rp.quarter, schemaName, tableName, rp.rpt_period_id, rp.rpt_period_id+1);
		RAISE NOTICE '%', sqlStatement;
		--EXECUTE sqlStatement;
	END LOOP;
END
$BODY$;
