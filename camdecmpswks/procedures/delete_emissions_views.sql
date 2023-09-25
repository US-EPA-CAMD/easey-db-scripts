-- PROCEDURE: camdecmpswks.delete_emissions_views(character varying)

DROP PROCEDURE IF EXISTS camdecmpswks.delete_emissions_views(character varying);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_emissions_views(
	vmonplanid character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	sqlStatement text;
	dataset record;
BEGIN
	FOR dataset IN (
    	SELECT * FROM camdaux.dataset
    	WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'DAILYBACKSTOP', 'COUNTS')
	) LOOP
		sqlStatement := format('
			DELETE FROM camdecmpswks.emission_view_%s
			WHERE mon_plan_id = %L;', dataset.dataset_cd, vMonPlanId);
		RAISE NOTICE 'Deleting data from %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;
	
	DELETE FROM camdecmpswks.emission_view_count WHERE mon_plan_id = vMonPlanId;
END
$BODY$;
