DO $$
DECLARE
	monPlanId text;
	currentQtr integer;
	currentYear integer;
	beginYear integer := 2020;
	endYear integer := 2022;
	orisCodes integer[] := ARRAY[3];
BEGIN
	FOR monPlanId IN (
		SELECT mp.mon_plan_id
		FROM camdecmps.monitor_plan mp
		JOIN camd.plant p USING(fac_id)
		WHERE p.oris_code = ANY(orisCodes) AND mp.end_rpt_period_id IS NULL
	)
	LOOP
		RAISE NOTICE 'Loading emissions data for %', monPlanId;
		FOR currentYear IN beginYear..endyear LOOP
			FOR currentQtr IN 1..4 LOOP
				CALL camdecmpswks.load_emissions_workspace(monPlanId, currentYear, currentQtr);
				CALL camdecmpswks.refresh_emissions_views(monPlanId, currentYear, currentQtr);				
			END LOOP;
		END LOOP;
	END LOOP;

END $$;
