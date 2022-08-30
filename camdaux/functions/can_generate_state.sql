-- FUNCTION: camdaux.can_generate_state(integer)

-- DROP FUNCTION camdaux.can_generate_state(integer);

CREATE OR REPLACE FUNCTION camdaux.can_generate_state(
	pyear integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
Declare 
	curReportingQuarter INTEGER;
	curYear INTEGER;
	curMonth INTEGER;
BEGIN
	curReportingQuarter := camdaux.get_current_submission_quarter();
	curYear := date_part('year'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	curMonth := date_part('month'::text, timezone('est'::text, CURRENT_TIMESTAMP));
		
	IF pYear > curYear THEN
		return false;
	END IF;
	
	IF curYear - pYear >= 2 THEN
		return true;
	END IF;
	
	IF curYear - pYear = 1 THEN
		if curMonth IN (1,2) AND curReportingQuarter = 4 THEN
			return false;
		ELSE
			return true;
		END IF;
	END IF;
	
	return false;
END;
$BODY$;
