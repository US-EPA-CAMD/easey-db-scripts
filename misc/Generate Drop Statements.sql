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

DROP SCHEMA camd;
DROP SCHEMA camdaux;
DROP SCHEMA camddmw;
DROP SCHEMA camddmw_arch;
DROP SCHEMA camdecmps;
DROP SCHEMA camdecmpsaux;
DROP SCHEMA camdecmpsmd;
DROP SCHEMA camdecmpswks;
DROP SCHEMA camdmd;
