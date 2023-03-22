-- PROCEDURE: camddmw_arch.create_unit_data_a_partitions(integer)

DROP PROCEDURE IF EXISTS camddmw_arch.create_unit_data_a_partitions(integer);

CREATE OR REPLACE PROCEDURE camddmw_arch.create_unit_data_a_partitions(
	year integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	toDate date;
	fromDate date;
	toMonth integer;
	fromMonth integer;
	tableName text;
	cmdStmt text;
BEGIN
	-- CREATE ARCHIVE PARTITIONS FOR THE SPECIFIED YEAR
	tableName := 'camddmw_arch.ozone_unit_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uo_%s PARTITION OF %s
		FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;

	tableName := 'camddmw_arch.annual_unit_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ua_%s PARTITION OF %s
		FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;

	tableName := 'camddmw_arch.quarter_unit_data_a';
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

	toMonth := 4;
	fromMonth := 13;
	tableName := 'camddmw_arch.month_unit_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, '1', tableName, year-1, fromMonth, year, toMonth);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..4 LOOP
		fromMonth := toMonth;
		toMonth := fromMonth + 3;
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, i, tableName, year, fromMonth, year, toMonth);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;

	toDate := format('%s-04-01', year);
	fromDate := format('%s-01-01', year);
	tableName := 'camddmw_arch.day_unit_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ud_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L) TO (%L);', tableName, year, '1', tableName, fromDate, toDate);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..4 LOOP
		fromDate := toDate;
		toDate := fromDate + INTERVAL '3 months';
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ud_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, i, tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;

	toDate := format('%s-04-01', year);
	fromDate := format('%s-01-01', year);
	tableName := 'camddmw_arch.hour_unit_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L) TO (%L);', tableName, year, '1', tableName, fromDate, toDate);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..4 LOOP
		fromDate := toDate;
		toDate := fromDate + INTERVAL '3 months';
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, i, tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;

	toDate := format('%s-04-01', year);
	fromDate := format('%s-01-01', year);
	tableName := 'camddmw_arch.hour_unit_mats_data_a';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L) TO (%L);', tableName, year, '1', tableName, fromDate, toDate);
	EXECUTE cmdStmt;
	RAISE NOTICE '%', cmdStmt;
	FOR i IN 2..4 LOOP
		fromDate := toDate;
		toDate := fromDate + INTERVAL '3 months';
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uh_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L) TO (%L);', tableName, year, i, tableName, fromDate, toDate);
		EXECUTE cmdStmt;
		RAISE NOTICE '%', cmdStmt;
	END LOOP;
END
$BODY$;
