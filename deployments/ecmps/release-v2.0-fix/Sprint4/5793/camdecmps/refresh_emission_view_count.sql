CREATE OR REPLACE PROCEDURE camdecmps.refresh_emission_view_count(IN vmonplanid character varying, IN vrptperiodid numeric, IN vdatasetcode character varying)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	sqlStatement text;
BEGIN
	DELETE FROM camdecmps.emission_view_count
	WHERE mon_plan_id = vmonplanid
	AND rpt_period_id = vrptperiodid
	AND dataset_cd = vdatasetcode;
	
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
	  WHERE mon_plan_id = %L
    AND rpt_period_id = %s
	  GROUP BY mon_plan_id, mon_loc_id, rpt_period_id;
	', vdatasetcode, vdatasetcode, vmonplanid, vrptperiodid);

	EXECUTE sqlStatement;

--	INSERT INTO camdecmps.emission_view_count(
--		mon_plan_id, mon_loc_id, dataset_cd, rpt_period_id, count
--	)
--	SELECT
--		mon_plan_id,
--		mon_loc_id,
--		vdatasetcode,
--		vrptperiodid,
--		0
--	FROM camdecmps.monitor_plan_location
--	WHERE mon_plan_id = vmonplanid
--	AND mon_loc_id NOT IN (
--		SELECT mon_loc_id
--		FROM camdecmps.emission_view_count
--		WHERE mon_plan_id = vmonplanid
--		AND rpt_period_id = vrptperiodid AND dataset_cd = vdatasetcode
--	);
END
$procedure$
