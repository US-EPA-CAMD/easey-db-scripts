SELECT 'SELECT ''' || table_schema || ''' AS schema_name, ''' || table_name || ''' AS table_name, COUNT(*) FROM ' || table_schema || '.' || table_name || ' UNION ALL'
FROM information_schema.tables
WHERE table_schema LIKE 'camd%'
	AND table_name NOT LIKE 'vw_%'
	AND table_name NOT LIKE 'qrtz_%'
	AND table_name NOT LIKE '%dim_%'
	AND table_name NOT LIKE '%data_a_%'
	AND table_name NOT LIKE '%data_dm_%'
	AND table_name NOT LIKE '%fact_%'
ORDER BY table_schema, table_name
;