-- PROCEDURE: camddmw.create_partitions(integer, character)

DROP PROCEDURE IF EXISTS camddmw.create_partitions(integer, character);

CREATE OR REPLACE PROCEDURE camddmw.create_partitions(
	year integer,
	executeflag character DEFAULT 'N'::bpchar)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	counter integer;
	toDate date;
	fromDate date;
	cmdStmt text;
	tableName text;
	partitionName text;
	partitionNumber integer;
	partitionExpression text;
	schemaName text := 'camddmw';
BEGIN
	IF executeFlag = 'N' THEN
		RAISE NOTICE 'The executeFlag is set to ''N'' so partitions will not be created. DRY RUN ONLY! Set executeFlag to ''Y'' to create partitions.';
	END IF;	

	--NEED TO DISCUSS HOW FAR OUT TO CREATE THESE
	--camddmw.allowance_holding_dim
	--CONSTRAINT allowance_holding_dim_all_hold_dim_p66_pkey PRIMARY KEY (vintage_year, prg_code, start_block)
	--FOR VALUES FROM ('2060') TO ('2061')

-------------------------------------------------------------------------------------------------------------------
	tableName := schemaName || '.annual_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_ua_%s PARTITION OF %s
				    FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	tableName := 'control_year_dim';
	partitionName := tableName || '_cntrl_yr_dim_p';
	EXECUTE format('
		SELECT MAX(CAST(REPLACE(table_name, %L, %L) AS integer))
		FROM information_schema.tables
		WHERE table_name like ''%s%%'';
	', partitionName, '', partitionName) INTO partitionNumber;
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s
				    FOR VALUES FROM (%L) TO (%L);', schemaName, partitionName, partitionNumber+1, schemaName, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	counter := 0;
	tableName := schemaName || '.day_unit_data';
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
		RAISE NOTICE '%', cmdStmt;
		IF executeFlag = 'Y' THEN
			EXECUTE cmdStmt;
			RAISE NOTICE '-- executed --';
		END IF;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;

-------------------------------------------------------------------------------------------------------------------
	tableName := 'fuel_year_dim';
	partitionName := tableName || '_fuel_yr_dim_p';
	EXECUTE format('
		SELECT MAX(CAST(REPLACE(table_name, %L, %L) AS integer))
		FROM information_schema.tables
		WHERE table_name like ''%s%%'';
	', partitionName, '', partitionName) INTO partitionNumber;
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s
				    FOR VALUES FROM (%L) TO (%L);', schemaName, partitionName, partitionNumber+1, schemaName, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	counter := 0;
	tableName := schemaName || '.hour_unit_data';
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
		RAISE NOTICE '%', cmdStmt;
		IF executeFlag = 'Y' THEN
			EXECUTE cmdStmt;
			RAISE NOTICE '-- executed --';
		END IF;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;

-------------------------------------------------------------------------------------------------------------------
	counter := 0;
	tableName := schemaName || '.hour_unit_mats_data';
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
		RAISE NOTICE '%', cmdStmt;
		IF executeFlag = 'Y' THEN
			EXECUTE cmdStmt;
			RAISE NOTICE '-- executed --';
		END IF;

		EXIT WHEN date_part('year', toDate) = year+1;
	END LOOP;

-------------------------------------------------------------------------------------------------------------------
	tableName := schemaName || '.month_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sm%s PARTITION OF %s
		FOR VALUES FROM (%L, ''13'') TO (%L, ''2'');', tableName, year, '01', tableName, year-1, year);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;
	FOR i IN 2..12 LOOP
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_um_%sm%s PARTITION OF %s
			FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, LPAD(CAST(i AS text), 2, '0'), tableName, year, i, year, i+1);
		RAISE NOTICE '%', cmdStmt;
		IF executeFlag = 'Y' THEN
			EXECUTE cmdStmt;
			RAISE NOTICE '-- executed --';
		END IF;
	END LOOP;

-------------------------------------------------------------------------------------------------------------------
	tableName := schemaName || '.ozone_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uo_%s PARTITION OF %s
				    FOR VALUES FROM (%L) TO (%L);', tableName, year, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	tableName := 'program_year_dim';
	partitionName := tableName || '_prg_year_dim_p';
	EXECUTE format('
		SELECT MAX(CAST(REPLACE(table_name, %L, %L) AS integer))
		FROM information_schema.tables
		WHERE table_name like ''%s%%'';
	', partitionName, '', partitionName) INTO partitionNumber;
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s
				    FOR VALUES FROM (%L) TO (%L);', schemaName, partitionName, partitionNumber+1, schemaName, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	tableName := schemaName || '.quarter_unit_data';
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uq_%sq%s PARTITION OF %s
		FOR VALUES FROM (%L, ''5'') TO (%L, ''2'');', tableName, year, '1', tableName, year-1, year);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;
	FOR i IN 2..4 LOOP
		cmdStmt := format('CREATE TABLE IF NOT EXISTS %s_dm_em_uq_%sq%s PARTITION OF %s
			FOR VALUES FROM (%L, %L) TO (%L, %L);', tableName, year, i, tableName, year, i, year, i+1);
		RAISE NOTICE '%', cmdStmt;
		IF executeFlag = 'Y' THEN
			EXECUTE cmdStmt;
			RAISE NOTICE '-- executed --';
		END IF;
	END LOOP;

-------------------------------------------------------------------------------------------------------------------
	tableName := 'unit_fact';
	partitionName := tableName || '_unit_fact_tmp_p';
	EXECUTE format('
		SELECT MAX(CAST(REPLACE(table_name, %L, %L) AS integer))
		FROM information_schema.tables
		WHERE table_name like ''%s%%'';
	', partitionName, '', partitionName) INTO partitionNumber;
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s
				    FOR VALUES FROM (%L) TO (%L);', schemaName, partitionName, partitionNumber+1, schemaName, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

-------------------------------------------------------------------------------------------------------------------
	tableName := 'unit_type_year_dim';
	partitionName := tableName || '_unit_type_yr_dim_p';
	EXECUTE format('
		SELECT MAX(CAST(REPLACE(table_name, %L, %L) AS integer))
		FROM information_schema.tables
		WHERE table_name like ''%s%%'';
	', partitionName, '', partitionName) INTO partitionNumber;
	cmdStmt := format('CREATE TABLE IF NOT EXISTS %s.%s%s PARTITION OF %s.%s
				    FOR VALUES FROM (%L) TO (%L);', schemaName, partitionName, partitionNumber+1, schemaName, tableName, year, year+1);
	RAISE NOTICE '%', cmdStmt;
	IF executeFlag = 'Y' THEN
		EXECUTE cmdStmt;
		RAISE NOTICE '-- executed --';
	END IF;

END
$BODY$;
