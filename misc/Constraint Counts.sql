SELECT nsp.nspname as schema, rel.relname as table, count(con.*) as count
FROM pg_catalog.pg_constraint con
INNER JOIN pg_catalog.pg_class rel
	ON rel.oid = con.conrelid
INNER JOIN pg_catalog.pg_namespace nsp
	ON nsp.oid = connamespace
WHERE nsp.nspname like 'camd%'
	AND rel.relname NOT LIKE '%dim_%'
	AND rel.relname NOT LIKE '%data_a_%'
	AND rel.relname NOT LIKE '%data_dm_%'
	AND rel.relname NOT LIKE '%fact_%'
GROUP BY nsp.nspname, rel.relname
ORDER BY nsp.nspname, rel.relname
;