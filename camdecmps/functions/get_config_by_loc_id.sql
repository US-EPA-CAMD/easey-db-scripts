-- FUNCTION: camdecmps.get_config_by_loc_id(character varying)

DROP FUNCTION IF EXISTS camdecmps.get_config_by_loc_id(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmps.get_config_by_loc_id(
	locationid character varying)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	identifier character varying;
BEGIN 
	SELECT coalesce(u.unitid, sp.stack_name) 
	INTO identifier
	FROM camdecmps.monitor_location ml
	LEFT JOIN camd.unit u USING(unit_id)
	LEFT JOIN camdecmps.stack_pipe sp USING(stack_pipe_id)
	WHERE ml.mon_loc_id = locationid;
	
	return identifier;
END
$BODY$;
