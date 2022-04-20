SELECT 'DELETE FROM ' || schemaname || '.'  || tablename || ' CASCADE;'
FROM pg_tables
WHERE schemaname like 'camd%'
	AND tablename NOT LIKE '%dim_%'
	AND tablename NOT LIKE '%data_a_%'
	AND tablename NOT LIKE '%data_dm_%'
	AND tablename NOT LIKE '%fact_%'
ORDER BY schemaname, tablename
;