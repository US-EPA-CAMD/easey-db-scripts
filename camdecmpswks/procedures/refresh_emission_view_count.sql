-- PROCEDURE: camdecmpswks.refresh_emission_view_count(character varying, numeric, text)

DROP PROCEDURE IF EXISTS camdecmpswks.refresh_emission_view_count(character varying, numeric, text);

CREATE OR REPLACE PROCEDURE camdecmpswks.refresh_emission_view_count(
	vmonplanid text,
	vrptperiodid numeric,
  vdatasetcode text
)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	sqlStatement text;
BEGIN
	DELETE FROM camdecmpswks.EMISSION_VIEW_COUNT
	WHERE MON_PLAN_ID = vMonPlanId
	AND RPT_PERIOD_ID = vRptPeriodId
	AND DATASET_CD = dataSetCode;
	
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
	  WHERE mon_plan_id = vMonPlanId
    AND rpt_period_id = vRptPeriodId
	  GROUP BY mon_plan_id, mon_loc_id, rpt_period_id;
	', dataset.dataset_cd, dataset.dataset_cd, vMonPlanId, vRptPeriodId);
	RAISE NOTICE 'Refreshing view counts for %...', dataset.display_name;
	EXECUTE sqlStatement;

	INSERT INTO camdecmpswks.emission_view_count(
		mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
	)
	SELECT
		mpl.mon_plan_id,
		mpl.mon_loc_id,
		dataSetCode,
		vRptPeriodId,
		0
	FROM camdecmpswks.monitor_plan_location AS mpl
	LEFT JOIN camdecmpswks.emission_view_count AS vw USING(mon_loc_id)
	WHERE mpl.mon_plan_id = vMonPlanId
	AND vw.mon_plan_id IS NULL
	AND vw.rpt_period_id IS NULL;
END
$BODY$;
