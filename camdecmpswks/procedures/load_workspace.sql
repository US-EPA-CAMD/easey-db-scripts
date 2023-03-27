-- PROCEDURE: camdecmpswks.load_workspace()

DROP PROCEDURE IF EXISTS camdecmpswks.load_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.load_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL camdecmpswks.delete_workspace();
	CALL camdecmpswks.load_monitor_plan_workspace();
	CALL camdecmpswks.load_qa_workspace();
	CALL camdecmpswks.load_emissions_workspace();
END;
$BODY$;
