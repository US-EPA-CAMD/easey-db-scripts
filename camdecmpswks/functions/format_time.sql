-- FUNCTION: camdecmpswks.format_time(numeric, numeric)

DROP FUNCTION IF EXISTS camdecmpswks.format_time(numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmpswks.format_time(
	hour numeric,
	minute numeric)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	result text;
	hourStr text;
	minStr text;
BEGIN
	minStr :=
		CASE
			WHEN minute < 10 THEN '0' || Coalesce(Cast(minute as text), '0')
		    ELSE Coalesce(Cast(minute as text), '00')
		END;

	hourStr :=
		CASE
			WHEN hour < 10 THEN '0' || Coalesce(Cast(hour as text), '0')
		    ELSE Coalesce(Cast(hour as text), '00')
		END;

	result :=
		CASE
			WHEN hour IS NULL AND minute IS NULL THEN NULL
			ELSE hourStr || ':' || minStr
		END;

	RETURN result;
END
$BODY$;
