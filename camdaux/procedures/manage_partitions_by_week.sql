DROP PROCEDURE IF EXISTS camdaux.manage_partitions_by_week(text,text,integer);

CREATE OR REPLACE PROCEDURE camdaux.manage_partitions_by_week(
	schemaName text,
	tableName text,
	maxYear integer
) LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	week text;
	tbl record;
	toDate date;
	fromDate date;
	year integer;
	counter integer := 0;
	sqlStatement text;
	correctTableName text;
BEGIN
	SELECT MAX(d.to_value)
	FROM (
		SELECT to_value::date
		FROM camdaux.get_partition_info(schemaName, tableName, 'W')
	) AS d INTO toDate;

	LOOP
		year := date_part('year', toDate);
		EXIT WHEN year = maxYear+1;
		fromDate := toDate;
		toDate := fromDate + INTERVAL '7 days';
		
		counter := counter+1;
		week := LPAD(counter::text, 2, '0');
		IF date_part('year', toDate) > date_part('year', fromDate) THEN
			counter := 0;
		END IF;

		sqlStatement := format('
			CREATE TABLE IF NOT EXISTS %s.%s_%sw%s PARTITION OF %s.%s
				FOR VALUES FROM (%L) TO (%L);
		', schemaName, tableName, year, week, schemaName, tableName, fromDate, toDate);
		RAISE NOTICE '%', sqlStatement;
		--EXECUTE sqlStatement;
	END LOOP;

	FOR tbl IN (
		SELECT table_name, from_value::date, to_value::date
		FROM camdaux.get_partition_info(schemaName, tableName, 'W')
	) LOOP
		correctTableName := format('%s_%s', tableName, RIGHT(tbl.table_name, 7));

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
