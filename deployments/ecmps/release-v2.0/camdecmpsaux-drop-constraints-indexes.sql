DO $$
DECLARE
	curCon record;
	curIndex record;
	curTable record;
	curColumn record;
	index integer;
	conCount integer;
	sqlStatement text := '';
	curSchema text := 'camdecmpsaux';
BEGIN
	IF (curSchema = 'camdecmps') THEN
		-- camdecmps ONLY (to handle partitioned tables)
		-- start with "grandparent" tables first
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema 
		and (table_name like 'hrly_op_data%')
		and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
		ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
		
		-- then "parent" tables
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema 
		and (table_name like 'daily_test_summary%' or table_name like 'hrly_fuel_flow%' or table_name like 'daily_emission%' or table_name like 'nsps4t_summary%' or table_name like 'sorbent_trap%' or table_name like 'weekly_test_summary%')
		and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
		ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
		
		--then the remaining "child" tables
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema
		and not (table_name like 'hrly_op_data%')
		and not (table_name like 'daily_test_summary%' or table_name like 'hrly_fuel_flow%' or table_name like 'daily_emission%' or table_name like 'nsps4t_summary%' or table_name like 'sorbent_trap%' or table_name like 'weekly_test_summary%')
		and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
	  ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
	ELSE
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema
	  and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
	  ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
	END IF;
	
	/*IF (curSchema = 'camdecmps') THEN
		-- camdecmps ONLY (to handle partitioned tables)
		-- drop foreign key constraints on partitions first
		-- start with "grandparent" tables first
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema 
		and (table_name like 'hrly_op_data%')
		and (table_name like '%_q1' or table_name like '%_q2' or table_name like '%_q3' or table_name like '%_q4')
		ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f' INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f')
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
		
		-- then "parent" tables
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema 
		and (table_name like 'daily_test_summary%' or table_name like 'hrly_fuel_flow%' or table_name like 'daily_emission%' or table_name like 'nsps4t_summary%' or table_name like 'sorbent_trap%' or table_name like 'weekly_test_summary%')
		and (table_name like '%_q1' or table_name like '%_q2' or table_name like '%_q3' or table_name like '%_q4')
		ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f' INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f')
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
		
		--then the remaining "child" tables
		FOR curTable IN select * from information_schema.tables where table_schema = curSchema
		and not (table_name like 'hrly_op_data%')
		and not (table_name like 'daily_test_summary%' or table_name like 'hrly_fuel_flow%' or table_name like 'daily_emission%' or table_name like 'nsps4t_summary%' or table_name like 'sorbent_trap%' or table_name like 'weekly_test_summary%')
	  and (table_name like '%_q1' or table_name like '%_q2' or table_name like '%_q3' or table_name like '%_q4')
	  ORDER BY table_name  
		LOOP
			index := 1;
			SELECT count(*) FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f' INTO conCount;
			
		  IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		  FOR curCon IN (SELECT con.* FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name AND con.contype = 'f')
		  LOOP
			IF (index = conCount) THEN
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
			ELSE
			  sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
			END IF;
			index := index + 1;
		  END LOOP;
			END IF;

			FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
			LOOP
				sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
			END LOOP;

			RAISE NOTICE '%', sqlStatement;
			EXECUTE sqlStatement;
			sqlStatement := '';

		END LOOP;
	END IF;*/
	
	/*FOR curTable IN select * from information_schema.tables where table_schema = curSchema
  and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
  ORDER BY table_name  
	LOOP
		index := 1;
		SELECT count(*) FROM pg_constraint con
		INNER JOIN pg_class rel ON rel.oid = con.conrelid
		INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
		WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
		
	  IF (conCount > 0) THEN
  		sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
      FOR curCon IN (SELECT con.* FROM pg_constraint con
        INNER JOIN pg_class rel ON rel.oid = con.conrelid
        INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
        WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
      LOOP
        IF (index = conCount) THEN
          sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE;', curCon.conname) || chr(10);
        ELSE
          sqlStatement := sqlStatement || format('	DROP CONSTRAINT IF EXISTS %s CASCADE,', curCon.conname) || chr(10);
        END IF;
        index := index + 1;
      END LOOP;
 		END IF;

		FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
		LOOP
			sqlStatement := sqlStatement || format('DROP INDEX IF EXISTS %s.%s CASCADE;', curSchema, curIndex.indexname) || chr(10);
		END LOOP;

		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
		sqlStatement := '';

	END LOOP;*/

	--RAISE NOTICE '%', sqlStatement;
	--EXECUTE sqlStatement;

END $$;
