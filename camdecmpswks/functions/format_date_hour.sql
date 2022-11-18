CREATE OR REPLACE FUNCTION camdecmpswks.format_date_hour(
	_datelabel date,
	_timehour numeric,
	_timeminute numeric)
    RETURNS varchar(25)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
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