-- PROCEDURE: camdecmps.refresh_emission_view_count()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emission_view_count();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_count()
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	TRUNCATE camdecmps.emission_view_count RESTART IDENTITY;
	
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd != 'COUNTS'
	LOOP
		sqlStatement := format('
			INSERT INTO camdecmps.emission_view_count(
				mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
			)
			SELECT
				mon_plan_id,
				mon_loc_id,
				%L AS dataset_cd,
				rpt_period_id,
				count(*) AS count
			FROM camdecmps.emission_view_%s
			GROUP BY mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id;
		', dataset.dataset_cd, dataset.dataset_cd);
		RAISE NOTICE 'Refreshing view counts for %...', dataset.display_name;
		EXECUTE sqlStatement;
	END LOOP;
END
$BODY$;
