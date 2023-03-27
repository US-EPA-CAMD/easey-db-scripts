-- PROCEDURE: camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(text)

DROP PROCEDURE IF EXISTS camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(
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

	DELETE FROM camdecmpswks.check_session
	WHERE mon_plan_id = monPlanId;

	DELETE FROM camdecmpsaux.evaluation_set
	WHERE mon_plan_id = monPlanId;
	
	DELETE FROM camdecmpswks.emission_evaluation
	WHERE mon_plan_id = monPlanId;

	DELETE FROM camdecmpswks.sorbent_trap
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.hrly_op_data
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.summary_value
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.nsps4t_summary
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.daily_emission
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.daily_test_summary
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.weekly_test_summary
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.long_term_fuel_flow
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.component_op_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.daily_test_supp_data
	WHERE mon_loc_id = ANY(monLocIds);

	DELETE FROM camdecmpswks.last_qa_value_supp_data
	WHERE mon_loc_id = ANY(monLocIds);
	
	DELETE FROM camdecmpswks.operating_supp_data
	WHERE mon_loc_id = ANY(monLocIds);
	
	DELETE FROM camdecmpswks.sorbent_trap_supp_data
	WHERE mon_loc_id = ANY(monLocIds);
	
	DELETE FROM camdecmpswks.system_op_supp_data
	WHERE mon_loc_id = ANY(monLocIds);
END;
$BODY$;
