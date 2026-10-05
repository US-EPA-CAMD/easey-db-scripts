-- PROCEDURE: camdecmps.refresh_emissions_views(character varying, numeric, numeric)

DROP PROCEDURE IF EXISTS camdecmps.refresh_emissions_views(character varying, numeric, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.refresh_emissions_views(
	vmonplanid character varying,
	vyear numeric,
	vquarter numeric)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	vRptPeriodId numeric(38,0);
	sqlStatement text;
	dataset record;
BEGIN
	SELECT rpt_period_id
	FROM camdecmpsmd.reporting_period
	WHERE calendar_year = vYear AND quarter = vQuarter
	INTO vRptPeriodId;

	RAISE NOTICE 'Refreshing Emissions data views for Monitor Plan [%] and Reporting Period [Id: %, Yr: %, Qrt: %],', vMonPlanId, vRptPeriodId, vYear, vQuarter;

	-- REFRESH EMISSION DATA VIEWS
	FOR dataset IN (
    SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW'
    AND dataset_cd NOT IN ('COUNTS')
  ) LOOP
		sqlStatement := format('CALL camdecmps.refresh_emission_view_%s(%L, %s);', dataset.dataset_cd, vMonPlanId, vRptPeriodId);
		RAISE NOTICE 'Refreshing %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;
END;
$BODY$;
