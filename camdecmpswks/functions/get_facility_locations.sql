-- FUNCTION: camdecmpswks.get_facility_locations(integer[])

DROP FUNCTION IF EXISTS camdecmpswks.get_facility_locations(integer[]);

CREATE OR REPLACE FUNCTION camdecmpswks.get_facility_locations(
	oriscodes integer[])
    RETURNS SETOF character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
begin
	return query select mon_loc_id from camd.plant
		join camdecmpswks.monitor_plan using(fac_id)
		join camdecmpswks.monitor_plan_location using(mon_plan_id)
		where oris_code = ANY(orisCodes);
END;
$BODY$;
