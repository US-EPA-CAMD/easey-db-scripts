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
	DELETE FROM camdecmpswks.emission_view_count
	WHERE mon_plan_id = vmonplanid
	AND rpt_period_id = vrptperiodid
	AND dataset_cd = vdatasetcode;
	
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
	  WHERE mon_plan_id = %L
    AND rpt_period_id = %s
	  GROUP BY mon_plan_id, mon_loc_id, rpt_period_id;
	', vdatasetcode, vdatasetcode, vmonplanid, vrptperiodid);

	EXECUTE sqlStatement;

	INSERT INTO camdecmpswks.emission_view_count(
		mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
	)
	SELECT
		mon_plan_id,
		mon_loc_id,
		vdatasetcode,
		vrptperiodid,
		0
	FROM camdecmpswks.monitor_plan_location
	WHERE mon_plan_id = vmonplanid
	AND mon_loc_id NOT IN (
		SELECT mon_loc_id
		FROM camdecmpswks.emission_view_count
		WHERE mon_plan_id = vmonplanid
		AND rpt_period_id = vrptperiodid AND dataset_cd = vdatasetcode
	);
END
$BODY$;
