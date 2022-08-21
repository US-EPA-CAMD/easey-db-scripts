-- PROCEDURE: camdecmpswks.revert_to_official_record(text)

-- DROP PROCEDURE camdecmpswks.revert_to_official_record(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
  	CALL camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(monplanid);
	CALL camdecmpswks.delete_monitor_plan_qa_data_from_workspace(monplanid);
	CALL camdecmpswks.delete_monitor_plan_from_workspace(monplanid);
	CALL camdecmpswks.copy_monitor_plan_to_workspace(monplanid);
  	CALL camdecmpswks.copy_monitor_plan_qa_data_to_workspace(monplanid);
  	CALL camdecmpswks.copy_monitor_plan_emissions_data_to_workspace(monplanid);
END;
$BODY$;
