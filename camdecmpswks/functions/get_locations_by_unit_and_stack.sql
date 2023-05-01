-- FUNCTION: camdecmpswks.get_locations_by_unit_and_stack(numeric, text[], text[])

DROP FUNCTION IF EXISTS camdecmpswks.get_locations_by_unit_and_stack(numeric, text[], text[]);

CREATE OR REPLACE FUNCTION camdecmpswks.get_locations_by_unit_and_stack(
	poriscode numeric,
	punitid text[],
	pstackpipeid text[])
    RETURNS SETOF character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
BEGIN
	return query 
	SELECT mon_loc_id FROM camdecmpswks.monitor_location ml
	LEFT JOIN camd.unit u USING(unit_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.plant p ON p.fac_id = u.fac_id or p.fac_id = sp.fac_id
	WHERE p.oris_code = porisCode AND (u.unitid = Any(punitid) OR sp.stack_name = Any(pstackpipeid));
END
$BODY$;
