-- PROCEDURE: camdecmpswks.revert_to_official_record(text)

DROP PROCEDURE IF EXISTS camdecmpswks.revert_to_official_record(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.revert_to_official_record(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
BEGIN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	DELETE FROM camdecmpswks.check_session WHERE mon_plan_id = monPlanId;
    CALL camdecmpswks.delete_emissions_views(monplanid);
    CALL camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(monplanid);
	CALL camdecmpswks.delete_monitor_plan_qa_data_from_workspace(monplanid);
	CALL camdecmpswks.delete_monitor_plan_data_from_workspace(monplanid);
	CALL camdecmpswks.copy_monitor_plan_to_workspace(monplanid, monLocIds);
    CALL camdecmpswks.copy_monitor_plan_qa_data_to_workspace(monLocIds);
    CALL camdecmpswks.copy_monitor_plan_emissions_data_to_workspace(monLocIds);
END;
$BODY$;
