-- PROCEDURE: camdecmps.refresh_emissions_views()

DROP PROCEDURE IF EXISTS camdecmps.refresh_emissions_views();

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emissions_views()
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	-- REFRESH EMISSION DATA VIEWS
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'DAILYBACKSTOP', 'COUNTS')
	LOOP
		sqlStatement := format('CALL camdecmps.refresh_emission_view_%s();', dataset.dataset_cd);
		RAISE NOTICE 'Refreshing %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;

	-- REFRESH EMISSION VIEW COUNTS
	CALL camdecmps.refresh_emission_view_count();
END;
$BODY$;
