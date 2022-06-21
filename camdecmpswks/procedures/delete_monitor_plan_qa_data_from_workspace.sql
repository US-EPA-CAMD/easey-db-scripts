-- PROCEDURE: camdecmpswks.delete_monitor_plan_qa_data_from_workspace(text)

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_qa_data_from_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_qa_data_from_workspace(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
BEGIN

	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	-- QA_SUPP_DATA --
	DELETE FROM camdecmpswks.qa_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	-- TEST_SUMMARY --
	DELETE FROM camdecmpswks.test_summary
	WHERE mon_loc_id = ANY(monLocIds);

	-- QA_CERT_EVENT --
	DELETE FROM camdecmpswks.qa_cert_event
	WHERE mon_loc_id = ANY(monLocIds);

	-- TEST_EXTENSION_EXEMPTION --
	DELETE FROM camdecmpswks.test_extension_exemption
	WHERE mon_loc_id = ANY(monLocIds);

END;
$BODY$;
