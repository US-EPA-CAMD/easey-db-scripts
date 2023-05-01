-- FUNCTION: camdecmpswks.get_plan_by_loc(text)

DROP FUNCTION IF EXISTS camdecmpswks.get_plan_by_loc(text);

CREATE OR REPLACE FUNCTION camdecmpswks.get_plan_by_loc(
	locid text)
    RETURNS character varying
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    
AS $BODY$
DECLARE
    _returnVal text;

begin
	SELECT mon_plan_id INTO _returnVal
	FROM camdecmpswks.monitor_plan_location
	JOIN camdecmpswks.monitor_plan mp using (mon_plan_id)  
	WHERE mp.end_rpt_period_id is null and mon_loc_id = locId;
	
	return _returnVal;
END;
$BODY$;
