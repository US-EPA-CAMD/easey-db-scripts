-- PROCEDURE: camddmw.create_unit_data_partitions(integer)

-- DROP PROCEDURE camddmw.create_unit_data_partitions(integer);

CREATE OR REPLACE PROCEDURE camddmw.create_unit_data_partitions(
	year integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	counter integer;
	toDate date;
	fromDate date;
	cmdStmt text;
	tableName text;
	partitionExpression text;
BEGIN
	tableName := 'camddmw.ozone_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uo_%s PARTITION OF %s
				    FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;

	tableName := 'camddmw.annual_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ua_%s PARTITION OF %s
				    FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;

	tableName := 'camddmw.quarter_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uq_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L, ''5'') TO (%L, ''2'');', tableName, year, '1', tableName, year-1, year);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..4 LOOP
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uq_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, i, tableName, year, i, year, i+1);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;

	tableName := 'camddmw.month_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sm%s PARTITION OF %s
		FOR VALUES FROM (%L, ''13'') TO (%L, ''2'');', tableName, year, '01', tableName, year-1, year);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..12 LOOP
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sm%s PARTITION OF %s
			FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, LPAD(CAST(i AS text), 2, '0'), tableName, year, i, year, i+1);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;

	counter := 0;
	tableName := 'camddmw.day_unit_data';
	EXECUTE format('
		SELECT pg_get_expr(pt.relpartbound, pt.oid, true)
		FROM pg_class base_tb 
		JOIN pg_inherits i on i.inhparent = base_tb.oid
		JOIN pg_class pt on pt.oid = i.inhrelid
		WHERE base_tb.oid = %L::regclass
		ORDER BY pt.relname DESC
		LIMIT 1;
	', tableName) INTO partitionExpression;
	
	toDate := SUBSTRING(partitionExpression, 37, 10);

	LOOP
		fromDate := toDate;
		counter := counter + 1;
		toDate := fromDate + INTERVAL '7 days';

		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ud_%sw%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, LPAD(CAST(counter AS text), 2, '0'), tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;

	counter := 0;
	tableName := 'camddmw.hour_unit_data';
	EXECUTE format('
		SELECT pg_get_expr(pt.relpartbound, pt.oid, true)
		FROM pg_class base_tb 
		JOIN pg_inherits i on i.inhparent = base_tb.oid
		JOIN pg_class pt on pt.oid = i.inhrelid
		WHERE base_tb.oid = %L::regclass
		ORDER BY pt.relname DESC
		LIMIT 1;
	', tableName) INTO partitionExpression;
	
	toDate := SUBSTRING(partitionExpression, 37, 10);

	LOOP
		fromDate := toDate;
		counter := counter + 1;
		toDate := fromDate + INTERVAL '7 days';

		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_%sw%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, LPAD(CAST(counter AS text), 2, '0'), tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;

	counter := 0;
	tableName := 'camddmw.hour_unit_mats_data';
	EXECUTE format('
		SELECT pg_get_expr(pt.relpartbound, pt.oid, true)
		FROM pg_class base_tb 
		JOIN pg_inherits i on i.inhparent = base_tb.oid
		JOIN pg_class pt on pt.oid = i.inhrelid
		WHERE base_tb.oid = %L::regclass
		ORDER BY pt.relname DESC
		LIMIT 1;
	', tableName) INTO partitionExpression;
	
	toDate := SUBSTRING(partitionExpression, 37, 10);

	LOOP
		fromDate := toDate;
		counter := counter + 1;
		toDate := fromDate + INTERVAL '7 days';

		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_mats_%sw%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, LPAD(CAST(counter AS text), 2, '0'), tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;
END
$BODY$;
