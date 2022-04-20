SELECT schemaname, tablename, count(*) as count
FROM pg_catalog.pg_indexes
WHERE schemaname like 'camd%'
	AND tablename NOT LIKE '%dim_%'
	AND tablename NOT LIKE '%data_a_%'
	AND tablename NOT LIKE '%data_dm_%'
	AND tablename NOT LIKE '%fact_%'
GROUP BY schemaname, tablename
ORDER BY schemaname, tablename
;