-- FUNCTION: camdaux.can_generate_compliance(integer, character varying)

-- DROP FUNCTION camdaux.can_generate_compliance(integer, character varying);

CREATE OR REPLACE FUNCTION camdaux.can_generate_compliance(
	pyear integer,
	pprgcode character varying)
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
declare
	curYear INTEGER;
	curMonth INTEGER;
	curDay INTEGER;

begin
	curYear := date_part('year'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	curMonth := date_part('month'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	curDay := date_part('day'::text, timezone('est'::text, CURRENT_TIMESTAMP));
	
	if pyear > curYear THEN
		return false;
	END IF;
	
	if curYear - pyear >= 2 THEN
		return true;
	END IF;
	
	if curYear - pyear = 1 THEN
		if pprgCode = 'ARP' THEN
			if curMonth >= 6 AND curDay >= 15 THEN
				return true;
			END IF;
		ELSE
			if curMonth >= 8 AND curDay >= 15 THEN
				return true;
			END IF;
		END IF;
	END IF;

    return false;
end;
$BODY$;
