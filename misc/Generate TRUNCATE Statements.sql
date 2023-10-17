SELECT 'TRUNCATE ' || schemaname || '.'  || tablename || ' CASCADE;'
FROM pg_tables
WHERE schemaname like 'camd%'
	AND tablename NOT LIKE '%q1'
	AND tablename NOT LIKE '%q2'
	AND tablename NOT LIKE '%q3'
	AND tablename NOT LIKE '%q4'
	AND tablename NOT LIKE '%dim_%'
	AND tablename NOT LIKE '%data_a_%'
	AND tablename NOT LIKE '%data_dm_%'
	AND tablename NOT LIKE '%fact_%'
ORDER BY schemaname, tablename
;