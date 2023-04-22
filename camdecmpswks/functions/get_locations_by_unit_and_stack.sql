CREATE OR REPLACE FUNCTION camdecmpswks.get_locations_by_unit_and_stack(
	porisCode numeric,
	punitId text,
	pstackPipeId text)
    RETURNS SETOF varchar(45)
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
	return query 
	SELECT mon_loc_id FROM camdecmpswks.monitor_location ml
	LEFT JOIN camd.unit u USING(unit_id)
	LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
	LEFT JOIN camd.plant p ON p.fac_id = u.fac_id or p.fac_id = sp.fac_id
	WHERE p.oris_code = porisCode AND (u.unitid = punitId OR sp.stack_name = pstackPipeId);
END
$BODY$;