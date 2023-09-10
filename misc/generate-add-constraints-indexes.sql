DO $$
DECLARE
	curCon record;
	curIndex record;
	curTable record;
	curColumn record;
	index integer;
	conCount integer;
	sqlStatement text := '';
	curSchema text := 'camdmd';
BEGIN
	FOR curTable IN select * from information_schema.tables where table_schema = curSchema
	LOOP
		index := 1;
		SELECT count(*) FROM pg_constraint con
		INNER JOIN pg_class rel ON rel.oid = con.conrelid
		INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
		WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name INTO conCount;
		
		FOR curIndex IN SELECT * FROM pg_indexes WHERE tablename = curTable.table_name
		LOOP
			sqlStatement := sqlStatement || format('%s;', replace(curIndex.indexdef, 'INDEX', 'INDEX IF NOT EXISTS')) || chr(10);
		END LOOP;
		
		sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
		FOR curCon IN (SELECT con.*, pg_get_constraintdef(con.oid, TRUE) as condef FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
			WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name)
		LOOP
			IF (index = conCount) THEN
				sqlStatement := sqlStatement || format('	ADD CONSTRAINT %s %s;', curCon.conname, curCon.condef) || chr(10);
			ELSE
				sqlStatement := sqlStatement || format('	ADD CONSTRAINT %s %s,', curCon.conname, curCon.condef) || chr(10);
			END IF;
			index := index + 1;
		END LOOP;
		
		RAISE NOTICE '%', sqlStatement;
	END LOOP;
END $$;
