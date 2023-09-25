-- PROCEDURE: camdecmpswks.delete_workspace()

DROP PROCEDURE IF EXISTS camdecmpswks.delete_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE TABLE camdecmpswks.check_session CASCADE;
	TRUNCATE TABLE camdecmpsaux.evaluation_set CASCADE;
  TRUNCATE TABLE camdecmpsaux.submission_set CASCADE;

	CALL camdecmpswks.delete_emissions_workspace();
	CALL camdecmpswks.delete_qa_workspace();
	CALL camdecmpswks.delete_monitor_plan_workspace();
END;
$BODY$;
