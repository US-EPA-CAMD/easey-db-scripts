-- PROCEDURE: camddmw.drop_unit_data_partitions(integer)

-- DROP PROCEDURE camddmw.drop_unit_data_partitions(integer);

CREATE OR REPLACE PROCEDURE camddmw.drop_unit_data_partitions(
	year integer)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	tableName text;
	tablePrefix text;
	currentTable text;
	currentPartition text;
	recordCount integer;
	tableList text[] := ARRAY [
	  'ozone_unit_data',
	  'annual_unit_data',
	  'quarter_unit_data',
	  'month_unit_data',
	  'day_unit_data',
	  'hour_unit_data',
	  'hour_unit_mats_data'
	];
BEGIN
	FOREACH currentTable IN ARRAY tableList LOOP
		RAISE NOTICE 'dropping partitions for %...', currentTable;

		IF currentTable = 'ozone_unit_data' THEN
			tablePrefix = format('%s_dm_em_uo_', currentTable);
			tableName = format('%s%s%%', tablePrefix, year);
		END IF;

		IF currentTable = 'annual_unit_data' THEN
			tablePrefix = format('%s_dm_em_ua_', currentTable);
			tableName = format('%s%s%%', tablePrefix, year);
		END IF;

		IF currentTable = 'quarter_unit_data' THEN
			tablePrefix = format('%s_dm_em_uq_', currentTable);
			tableName = format('%s%sq%%', tablePrefix, year);
		END IF;

		IF currentTable = 'month_unit_data' THEN
			tablePrefix = format('%s_dm_em_um_', currentTable);
			tableName = format('%s%sm%%', tablePrefix, year);
		END IF;

		IF currentTable = 'day_unit_data' THEN
			tablePrefix = format('%s_dm_em_ud_', currentTable);
			tableName = format('%s%sw%%', tablePrefix, year);
		END IF;

		IF currentTable = 'hour_unit_data' THEN
			tablePrefix = format('%s_dm_em_uh_', currentTable);
			tableName = format('%s%sw%%', tablePrefix, year);
		END IF;

		IF currentTable = 'hour_unit_mats_data' THEN
			tablePrefix = format('%s_dm_em_uh_mats_', currentTable);
			tableName = format('%s%sw%%', tablePrefix, year);
		END IF;

		FOR currentPartition IN EXECUTE format('SELECT tablename FROM pg_tables WHERE tablename like %L ORDER BY tablename;', tableName)
		LOOP
			EXECUTE format('SELECT COUNT(*) FROM camddmw.%s WHERE op_year = %s;', currentPartition, year+1) INTO recordCount;
			IF recordCount > 0 THEN
				RAISE NOTICE 'cannot drop % since the partition data spans % & %', currentPartition, year, year+1;
			ELSE
				EXECUTE format('DROP TABLE IF EXISTS camddmw.%s;', currentPartition);
				RAISE NOTICE 'dropped partition %', currentPartition;
			END IF;
		END LOOP;

		EXECUTE format('DELETE FROM camddmw.%s WHERE op_year = %s;', currentTable, year);
		RAISE NOTICE 'deleted % data from %', year, currentTable;

		RAISE NOTICE 'checking % partitions for %...', year-1, currentTable;
		tableName = format('%s%s%%', tablePrefix, year-1);
		FOR currentTable IN EXECUTE format('SELECT tablename FROM pg_tables WHERE tablename like %L ORDER BY tablename;', tableName)
		LOOP
			EXECUTE format('SELECT COUNT(*) FROM camddmw.%s;', currentTable) INTO recordCount;
			RAISE NOTICE 'partition % exists and has % records', currentTable, recordCount;
			IF recordCount = 0 THEN
				EXECUTE format('DROP TABLE IF EXISTS camddmw.%s;', currentTable);
				RAISE NOTICE 'dropped partition camddmw.%', currentTable;
			END IF;
		END LOOP;
	END LOOP;
END
$BODY$;
