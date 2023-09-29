-- FUNCTION: camdecmpsaux.get_mp_location_list(character varying)

DROP FUNCTION IF EXISTS camdecmpsaux.get_mp_location_list(character varying) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.get_mp_location_list(
	inmonplandid character varying)
    RETURNS text
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
	LOCATION_LIST text;
BEGIN

	SELECT string_agg(locations, ', ') as locations
	INTO LOCATION_LIST
	FROM
	(
	SELECT MPL.MON_PLAN_ID, COALESCE(U.UNITID, SP.STACK_NAME) as locations
	FROM camdecmps.MONITOR_PLAN_LOCATION MPL
	JOIN CAMDECMPS.MONITOR_LOCATION ML ON MPL.MON_LOC_ID = ML.MON_LOC_ID
	LEFT JOIN camdecmps.STACK_PIPE SP ON ML.STACK_PIPE_ID = SP.STACK_PIPE_ID
	LEFT JOIN camd.UNIT U ON ML.UNIT_ID = U.UNIT_ID
	WHERE MPL.MON_PLAN_ID = inmonplandid
	ORDER BY U.UNITID, SP.STACK_NAME
	) sub
	GROUP BY sub.mon_plan_id;
    
    RETURN LOCATION_LIST;
END;
$BODY$;
