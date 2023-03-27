-- FUNCTION: camdecmpswks.check_location_belongs_under_facilities(text, integer[])

DROP FUNCTION IF EXISTS camdecmpswks.check_location_belongs_under_facilities(text, integer[]);

CREATE OR REPLACE FUNCTION camdecmpswks.check_location_belongs_under_facilities(
	loc text,
	inhour integer[])
    RETURNS boolean
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
begin 
	RETURN true;
END;
$BODY$;
