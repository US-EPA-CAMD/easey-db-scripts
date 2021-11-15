-- PROCEDURE: camdecmpswks.revert_to_official_record(text)

-- DROP PROCEDURE camdecmpswks.revert_to_official_record(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  	CALL camdecmpswks.delete_workspace_monitor_plan(monplanid);
  	CALL camdecmpswks.copy_monitor_plan_to_workspace(monplanid);
END;
$BODY$;
