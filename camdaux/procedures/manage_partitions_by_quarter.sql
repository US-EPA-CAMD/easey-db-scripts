DROP PROCEDURE IF EXISTS camdaux.manage_partitions_by_quarter(text,text,integer);

CREATE OR REPLACE PROCEDURE camdaux.manage_partitions_by_quarter(
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
	SELECT MAX(d.to_value) + 1
	FROM (
		SELECT to_value::numeric
		FROM camdaux.get_partition_info(schemaName, tableName, 'Q')
	) AS d INTO year;

	FOR yr IN year..maxYear LOOP
		FOR qtr IN 1..4 LOOP
			sqlStatement := format('
				CREATE TABLE IF NOT EXISTS %s.%s_%sq%s PARTITION OF %s.%s
					FOR VALUES FROM (%L, %L) TO (%L, %L);
			', schemaName, tableName, yr, qtr, schemaName, tableName, yr, qtr, yr, qtr+1);
			RAISE NOTICE '%', sqlStatement;
			--EXECUTE sqlStatement;
		END LOOP;
	END LOOP;

	FOR tbl IN (
		SELECT table_name, from_value::numeric, to_value::numeric
		FROM camdaux.get_partition_info(schemaName, tableName, 'Q')
	) LOOP
		correctTableName := format('%s_%s', tableName, RIGHT(tbl.table_name, 6));

		IF tbl.table_name <> correctTableName THEN
			sqlStatement := format(
				'ALTER TABLE IF EXISTS %s.%s RENAME TO %s',
				schemaName, tbl.table_name, correctTableName
			);
			RAISE NOTICE '%', sqlStatement;
			--EXECUTE sqlStatement;

			sqlStatement := format(
				'ALTER TABLE IF EXISTS %s.%s
    				RENAME CONSTRAINT %s_pkey TO pk_%s;',
				schemaName, correctTableName, tbl.table_name, correctTableName
			);
			RAISE NOTICE '%', sqlStatement;
			--EXECUTE sqlStatement;
		END IF;
	END LOOP;
END
$BODY$;
