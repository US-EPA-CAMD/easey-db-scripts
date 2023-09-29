-- FUNCTION: camdaux.can_generate_quarter(integer, integer)

DROP FUNCTION IF EXISTS camdaux.can_generate_quarter(integer, integer) CASCADE;

CREATE OR REPLACE FUNCTION camdaux.can_generate_quarter(
	pquarter integer,
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
		IF pQuarter = 4 THEN
			IF curMonth IN (1,2) AND curReportingQuarter = 4 THEN
				return false;
			ELSE
				return true;
			END IF;
		ELSE
			return true;
		END IF;
	END IF;
	
	IF curYear - pYear = 0 THEN
		IF pQuarter < curReportingQuarter THEN
			return true;
		END IF;
	END IF;
	
	return false;
END;
$BODY$;
