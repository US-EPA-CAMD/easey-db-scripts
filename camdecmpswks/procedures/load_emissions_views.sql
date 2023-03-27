-- PROCEDURE: camdecmpswks.load_emissions_views(integer, integer, integer[])

DROP PROCEDURE IF EXISTS camdecmpswks.load_emissions_views(integer, integer, integer[]);

CREATE OR REPLACE PROCEDURE camdecmpswks.load_emissions_views(
	beginyear integer,
	endyear integer,
	oriscodes integer[])
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	facility text;
	monPlanId text;
	currentQtr integer;
	currentYear integer;
BEGIN
	FOR monPlanId, facility IN (
		SELECT mp.mon_plan_id, p.facility_name
		FROM camdecmps.monitor_plan mp
		JOIN camd.plant p USING(fac_id)
		WHERE p.oris_code = ANY(orisCodes) AND mp.end_rpt_period_id IS NULL
	)
	LOOP
		RAISE NOTICE 'Loading emissions data for % %', facility, monPlanId;
		FOR currentYear IN beginYear..endyear LOOP
			FOR currentQtr IN 1..4 LOOP
				CALL camdecmpswks.load_emissions_workspace(monPlanId, currentYear, currentQtr);
				CALL camdecmpswks.refresh_emissions_views(monPlanId, currentYear, currentQtr);				
			END LOOP;
		END LOOP;
	END LOOP;

END;
$BODY$;
