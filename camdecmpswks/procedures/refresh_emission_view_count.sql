-- PROCEDURE: camdecmpswks.refresh_emission_view_count(character varying, numeric)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_count(character varying, numeric);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_count(
	vmonplanid character varying,
	vrptperiodid numeric
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	dataset record;
	sqlStatement text;
BEGIN
	DELETE FROM camdecmpswks.EMISSION_VIEW_COUNT
	WHERE MON_PLAN_ID = vMonPlanId AND RPT_PERIOD_ID = vRptPeriodId;
	
	FOR dataset IN SELECT * FROM camdaux.dataset WHERE group_cd = 'EMVIEW' AND dataset_cd != 'COUNTS'
	LOOP
		sqlStatement := format('
			INSERT INTO camdecmpswks.emission_view_count(
				mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
			)
			SELECT
				mon_plan_id,
				mon_loc_id,
				%L AS dataset_cd,
				rpt_period_id,
				count(*) AS count
			FROM camdecmpswks.emission_view_%s
			WHERE mon_plan_id = %L AND rpt_period_id = %s
			GROUP BY mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id;
		', dataset.dataset_cd, dataset.dataset_cd, vMonPlanId, vRptPeriodId);
		RAISE NOTICE 'Refreshing view counts for %...', dataset.display_name;
		EXECUTE sqlStatement;
	END LOOP;
END
$BODY$;
