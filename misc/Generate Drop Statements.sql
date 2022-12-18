SELECT 'DROP VIEW IF EXISTS ' || table_schema || '.'  || table_name || ' CASCADE;'
FROM information_schema.views
WHERE table_schema like'camd%'
ORDER BY table_schema, table_name
;

SELECT format('DROP %I IF EXISTS %I.%I(%s) CASCADE;',
	CASE
		WHEN p.prokind = 'p' THEN 'PROCEDURE'
		WHEN p.prokind = 'f' THEN 'FUNCTION'
		ELSE 'ROUTINE'
	END,
	ns.nspname, p.proname, oidvectortypes(p.proargtypes)) 
FROM pg_proc p
INNER JOIN pg_namespace ns
	ON (p.pronamespace = ns.oid)
WHERE ns.nspname like 'camd%'
ORDER BY ns.nspname
;

SELECT 'DROP TABLE IF EXISTS ' || schemaname || '.'  || tablename || ' CASCADE;'
FROM pg_tables
WHERE schemaname like 'camd%'
	AND tablename NOT LIKE '%dim_%'
	AND tablename NOT LIKE '%data_a_%'
	AND tablename NOT LIKE '%data_dm_%'
	AND tablename NOT LIKE '%fact_%'
ORDER BY schemaname, tablename
;

DROP SCHEMA IF EXISTS camd CASCADE;
DROP SCHEMA IF EXISTS camdaux CASCADE;
DROP SCHEMA IF EXISTS camddmw CASCADE;
DROP SCHEMA IF EXISTS camddmw_arch CASCADE;
DROP SCHEMA IF EXISTS camdecmps CASCADE;
DROP SCHEMA IF EXISTS camdecmpsaux CASCADE;
DROP SCHEMA IF EXISTS camdecmpscalc CASCADE;
DROP SCHEMA IF EXISTS camdecmpsmd CASCADE;
DROP SCHEMA IF EXISTS camdecmpswks CASCADE;
DROP SCHEMA IF EXISTS camdmd CASCADE;
