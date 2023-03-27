-- FUNCTION: camdecmpswks.get_facility_plans(integer[])

DROP FUNCTION IF EXISTS camdecmpswks.get_facility_plans(integer[]);

CREATE OR REPLACE FUNCTION camdecmpswks.get_facility_plans(
	oriscodes integer[])
    RETURNS SETOF character varying 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
    
AS $BODY$
begin
	return query select mon_plan_id from camd.plant
		join camdecmpswks.monitor_plan using(fac_id)
		where oris_code = ANY(orisCodes);
END;
$BODY$;
