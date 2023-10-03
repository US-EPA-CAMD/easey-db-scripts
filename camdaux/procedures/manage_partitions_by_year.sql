DROP PROCEDURE IF EXISTS camdaux.manage_partitions_by_year(text,text,integer);

CREATE OR REPLACE PROCEDURE camdaux.manage_partitions_by_year(
	schemaName text,
	tableName text,
	maxYear integer
) LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	tbl record;
	year integer;
	sqlStatement text;
	correctTableName text;
BEGIN
	SELECT MAX(d.to_value)
	FROM (
		SELECT to_value::numeric
		FROM camdaux.get_partition_info(schemaName, tableName)
	) AS d INTO year;

	FOR yr IN year..maxYear LOOP
		sqlStatement := format('
			CREATE TABLE IF NOT EXISTS %s.%s_%s PARTITION OF %s.%s
				FOR VALUES FROM (%L) TO (%L);
		', schemaName, tableName, yr, schemaName, tableName, yr, yr+1);
		RAISE NOTICE '%', sqlStatement;
		--EXECUTE sqlStatement;
	END LOOP;

	FOR tbl IN (
		SELECT table_name, from_value::numeric, to_value::numeric
		FROM camdaux.get_partition_info(schemaName, tableName)
	) LOOP
		correctTableName := format('%s_%s', tableName, tbl.from_value);

		IF tbl.from_value IS NULL THEN
			correctTableName := format('%s_before_%s', tableName, tbl.to_value);
		END IF;
	
		IF tbl.table_name <> correctTableName THEN
			sqlStatement := format(
				'ALTER TABLE IF EXISTS %s.%s RENAME TO %s',
				schemaName, tbl.table_name, correctTableName
			);
			RAISE NOTICE '%', sqlStatement;
			sqlStatement := format(
				'ALTER TABLE IF EXISTS %s.%s
    				RENAME CONSTRAINT %s_pkey TO pk_%s;',
				schemaName, correctTableName, tbl.table_name, correctTableName
			);
			RAISE NOTICE '%', sqlStatement;
		END IF;
	END LOOP;
END
$BODY$;
