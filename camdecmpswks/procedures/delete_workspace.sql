-- PROCEDURE: camdecmpswks.delete_workspace()

-- DROP PROCEDURE camdecmpswks.delete_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	CALL camdecmpswks.delete_emissions_workspace();
	CALL camdecmpswks.delete_qa_workspace();
	CALL camdecmpswks.delete_monitor_plan_workspace();
END;
$BODY$;
