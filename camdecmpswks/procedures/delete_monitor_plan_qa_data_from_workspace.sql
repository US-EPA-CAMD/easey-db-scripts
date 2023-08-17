-- PROCEDURE: camdecmpswks.delete_monitor_plan_qa_data_from_workspace(text)

DROP PROCEDURE IF EXISTS camdecmpswks.delete_monitor_plan_qa_data_from_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_qa_data_from_workspace(
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
	
	DELETE FROM camdecmpswks.check_session
	WHERE mon_plan_id = monPlanId;

	DELETE FROM camdecmpsaux.evaluation_set
	WHERE mon_plan_id = monPlanId;	

	DELETE FROM camdecmpswks.qa_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.test_summary
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.qa_cert_event
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.qa_cert_event_supp_data
	WHERE mon_loc_id = ANY(monLocIds); 

	DELETE FROM camdecmpswks.test_extension_exemption
	WHERE mon_loc_id = ANY(monLocIds);
END;
$BODY$;
