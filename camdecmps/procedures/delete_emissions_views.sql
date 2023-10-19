-- PROCEDURE: camdecmpswks.delete_emissions_views(character varying)

DROP PROCEDURE IF EXISTS camdecmps.delete_emissions_views(character varying, vrptperiodid numeric);

CREATE OR REPLACE PROCEDURE camdecmps.delete_emissions_views(
	vmonplanid character varying, vrptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	sqlStatement text;
	dataset record;
BEGIN

	FOR dataset IN (
    	SELECT * FROM camdaux.dataset
    	WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'SUMVAL', 'DAILYBACKSTOP', 'COUNTS')
	) LOOP
		sqlStatement := format('
			DELETE FROM camdecmps.emission_view_%s
			WHERE mon_plan_id = %L AND rpt_period_id = %L;', dataset.dataset_cd, vmonplanid, vrptperiodid);
		RAISE NOTICE 'Deleting data from %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;
	
	DELETE FROM camdecmps.emission_view_count WHERE mon_plan_id = vMonPlanId AND rpt_period_id = vrptperiodid;
END
$BODY$;
