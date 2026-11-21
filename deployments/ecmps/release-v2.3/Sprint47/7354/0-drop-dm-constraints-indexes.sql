DO $$
DECLARE
	curCon record;
	curIndex record;
	curTable record;
	curColumn record;
	index integer;
	conCount integer;
	sqlStatement text := '';
	curSchema text := 'camddmw';
BEGIN
	FOR curTable IN 
		select table_name 
		from information_schema.tables 
		where table_schema = curSchema
			and table_name in ('account_compliance_dim', 'account_fact', 'account_owner_dim', 'account_rep_dim',
							   'allowance_holding_dim', 'allowance_valid_year', 'bank_dim', 'control_year_dim', 
							   'fuel_year_dim', 'monitor_fact', 'op_status_year_dim', 'op_year',
							   'owner_display_fact', 'owner_year_dim', 'program_year_dim', 
							   'rep_display_fact', 'rep_year_dim', 'state_allocation_fact', 'state_alternate_ozone_began',
							   'transaction_block_dim', 'transaction_fact', 'transaction_owner_dim',
							   'unit_compliance_dim', 'unit_fact', 'unit_phase_year_dim', 'unit_type_year_dim', 'valid_year')
	LOOP
		index := 1;
		SELECT count(*) 
		FROM pg_constraint con
			INNER JOIN pg_class rel ON rel.oid = con.conrelid
			INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
		WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name 
		INTO conCount;
		
		IF (conCount > 0) THEN
			sqlStatement := sqlStatement || format('ALTER TABLE IF EXISTS %s.%s', curSchema, curTable.table_name) || chr(10);
			
			FOR curCon IN 
				SELECT con.* FROM pg_constraint con
					INNER JOIN pg_class rel ON rel.oid = con.conrelid
					INNER JOIN pg_namespace nsp ON nsp.oid = connamespace
				WHERE nsp.nspname = curSchema AND rel.relname = curTable.table_name
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
