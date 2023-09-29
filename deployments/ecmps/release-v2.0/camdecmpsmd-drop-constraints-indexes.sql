DO $$
DECLARE
	curCon record;
	curIndex record;
	curTable record;
	curColumn record;
	index integer;
	conCount integer;
	sqlStatement text := '';
	curSchema text := 'camdecmpsmd';
BEGIN
	FOR curTable IN select * from information_schema.tables where table_schema = curSchema
  and table_name not like '%_q1' and table_name not like '%_q2' and table_name not like '%_q3' and table_name not like '%_q4'
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

	END LOOP;

  --RAISE NOTICE '%', sqlStatement;
	EXECUTE sqlStatement;

END $$;
