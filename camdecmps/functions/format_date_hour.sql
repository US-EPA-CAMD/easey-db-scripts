-- FUNCTION: camdecmps.format_date_hour(date, numeric, numeric)

DROP FUNCTION IF EXISTS camdecmps.format_date_hour(date, numeric, numeric);

CREATE OR REPLACE FUNCTION camdecmps.format_date_hour(
	_datelabel date,
	_timehour numeric,
	_timeminute numeric
)
RETURNS character varying
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	returnVal varchar(25);
BEGIN
	returnVal := to_char(_datelabel, 'MM/DD/YYYY');
	
	If _timehour IS NOT NULL THEN
		returnVal := returnVal || ' ' || TO_CHAR(_timehour, 'fm00');
		
		If _timeminute IS NOT NULL THEN
			returnVal := returnVal || ':' || TO_CHAR(_timeminute, 'fm00');
		ELSE
			returnVal := returnVal || ':00';
		END IF;
	END IF;
	
return returnVal;
END;
$BODY$;
