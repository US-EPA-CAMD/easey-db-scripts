-- FUNCTION: camdecmpswks.format_indicator(numeric, boolean)

DROP FUNCTION IF EXISTS camdecmpswks.format_indicator(numeric, boolean) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.format_indicator(
	value numeric,
	allownull boolean)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
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

-- FUNCTION: camdecmpswks.format_indicator(numeric)

DROP FUNCTION IF EXISTS camdecmpswks.format_indicator(numeric) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.format_indicator(
	value numeric)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
BEGIN
	RETURN camdecmpswks.format_indicator(value, false);
END;
$BODY$;
