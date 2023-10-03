DROP FUNCTION IF EXISTS camdaux.get_partition_info(text,text,text);

CREATE OR REPLACE FUNCTION camdaux.get_partition_info(
	schemaName text,
	tableName text,
	regexType text
)
RETURNS TABLE(table_name text, expression text, from_value text, to_value text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	regex text := '[0-9]+';
	forValuesFrom text := 'FOR VALUES FROM ';
	dates text := '\d{4}-([0]\d|1[0-2])-([0-2]\d|3[01])';
	regex1 text;regex2 text;regex3 text;regex4 text;
	regex5 text;regex6 text;regex7 text;regex8 text;
BEGIN
	IF regexType = 'W' THEN
		regex = dates;
	END IF;
	
	regex1 := forValuesFrom || '(''';
	regex2 := '''\) TO \(''' || regex || '''\)';
	regex3 := forValuesFrom || '(';
	regex4 := '\) TO \(' || regex || '\)';
	regex5 := forValuesFrom || '\(''' || regex || '''\) TO \(''';
	regex6 := '''\)';
	regex7 := forValuesFrom || '\(' || regex || '\) TO \(';
	regex8 := ')';

	IF regexType = 'M' OR regexType = 'Q' THEN
		regex2 := ''', ''' || regex || '''\) TO \(''' || regex || ''', ''' || regex || '''\)';
		regex4 := ', ' || regex || '\) TO \(' || regex || ', ' || regex || '\)';
		regex5 := forValuesFrom || '\(''' || regex || ''', ''' || regex || '''\) TO \(''';
		regex6 := ''', ''' || regex || '''\)';
		regex7 := forValuesFrom || '\(' || regex || ', ' || regex || '\) TO \(';
		regex8 := ', ' || regex || '\)';		
	END IF;

	RETURN QUERY
	SELECT
    	pt.relname::text AS table_name,
		pg_get_expr(pt.relpartbound, pt.oid, true) AS expression,
		CASE
			WHEN pg_get_expr(pt.relpartbound, pt.oid, true) LIKE '%MINVALUE%' THEN null
			WHEN pg_get_expr(pt.relpartbound, pt.oid, true) LIKE '%''%' THEN
				REGEXP_REPLACE(
					REPLACE(
						pg_get_expr(pt.relpartbound, pt.oid, true),
						regex1,	''
					), regex2, ''
				)
			ELSE
				REGEXP_REPLACE(
					REPLACE(
						pg_get_expr(pt.relpartbound, pt.oid, true),
						regex3,	''
					), regex4, ''
				)
		END AS from_value,
		CASE
			WHEN pg_get_expr(pt.relpartbound, pt.oid, true) LIKE '%MINVALUE%' THEN
				REGEXP_REPLACE(
					REPLACE(
						pg_get_expr(pt.relpartbound, pt.oid, true),
						'FOR VALUES FROM (MINVALUE) TO (''', ''
					), regex6, ''
				)
			WHEN pg_get_expr(pt.relpartbound, pt.oid, true) LIKE '%''%' THEN
				REGEXP_REPLACE(
					REGEXP_REPLACE(
						pg_get_expr(pt.relpartbound, pt.oid, true),
						regex5,	''
					), regex6, ''
				)
			ELSE
				REPLACE(
					REGEXP_REPLACE(
						pg_get_expr(pt.relpartbound, pt.oid, true),
						regex7,	''
					), regex8, ''
				)
		END AS to_value
	FROM pg_class base_tb
	JOIN pg_inherits i on i.inhparent = base_tb.oid
	JOIN pg_class pt on pt.oid = i.inhrelid
	WHERE base_tb.oid = format('%s.%s', schemaName, tableName)::regclass;
END;
$BODY$;


DROP FUNCTION IF EXISTS camdaux.get_partition_info(text,text);

CREATE OR REPLACE FUNCTION camdaux.get_partition_info(
	schemaName text,
	tableName text
)
RETURNS TABLE(table_name text, expression text, from_value text, to_value text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN QUERY SELECT *
	FROM camdaux.get_partition_info(schemaName, tableName, null);
END;
$BODY$;
