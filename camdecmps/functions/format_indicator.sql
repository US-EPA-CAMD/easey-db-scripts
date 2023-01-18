-- FUNCTION: camdecmps.format_indicator(numeric)

DROP FUNCTION IF EXISTS camdecmps.format_indicator(numeric);

CREATE OR REPLACE FUNCTION camdecmps.format_indicator(
	value numeric
)
RETURNS text
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	RETURN camdecmps.format_indicator(value, false);
END;
$BODY$;

-- FUNCTION: camdecmps.format_indicator(numeric, bool)

DROP FUNCTION IF EXISTS camdecmps.format_indicator(numeric, bool);

CREATE OR REPLACE FUNCTION camdecmps.format_indicator(
	value numeric,
	allowNull bool
)
RETURNS text
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	IF value IS NULL AND allowNull = true THEN
		RETURN null;
	ELSEIF value = 1 THEN
		RETURN 'Yes';
	ELSE RETURN 'No';
	END IF;
END;
$BODY$;
