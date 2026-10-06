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
    	WHERE group_cd = 'EMVIEW' AND dataset_cd NOT IN ('LTFF', 'NSPS4T', 'SUMVAL', 'DAILYBACKSTOP', 'COUNTS')
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


DROP PROCEDURE camdecmpswks.delete_emissions_views(character varying, numeric, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_emissions_views
(
    IN vmonplanid character varying,
    IN vyear numeric,
    IN vquarter numeric
)
LANGUAGE plpgsql
AS $procedure$
DECLARE
	vRptPeriodId numeric(38,0);
	sqlStatement text;
	dataset record;
BEGIN
	
    -- Get RPT_PERIOD_ID
    SELECT  rpt_period_id
	  FROM  camdecmpsmd.REPORTING_PERIOD
	 WHERE  calendar_year = vYear AND quarter = vQuarter
	  INTO  vRptPeriodId;

	RAISE NOTICE 'Deleting Emissions data views for Monitor Plan [%] and Reporting Period [Id: %, Yr: %, Qrt: %],', vMonPlanId, vRptPeriodId, vYear, vQuarter;

	-- DELETE EMISSION DATA VIEWS
	FOR dataset IN
    (
        SELECT  *
          FROM  camdaux.DATASET
         WHERE  group_cd = 'EMVIEW'
           AND  dataset_cd NOT IN ( 'COUNTS', 'DAILYBACKSTOP', 'LTFF', 'NSPS4T', 'SUMVAL' )
    ) 
    LOOP
		sqlStatement := format('DELETE FROM camdecmpswks.EMISSION_VIEW_%s WHERE MON_PLAN_ID = %L AND RPT_PERIOD_ID = %s;', dataset.dataset_cd, vMonPlanId, vRptPeriodId);
		RAISE NOTICE 'Deleting %...', dataset.display_name;
		RAISE NOTICE '%', sqlStatement;
		EXECUTE sqlStatement;
	END LOOP;
    
    -- Delete Counts
    DELETE
      FROM  camdecmpswks.emission_view_count
     WHERE  mon_plan_id = vMonPlanId
       AND  rpt_period_id = vRptPeriodId;

END;
$procedure$
;
