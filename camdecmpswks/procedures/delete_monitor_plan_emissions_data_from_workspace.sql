-- PROCEDURE: camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(text)

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(text);

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

	DELETE FROM camdecmpswks.emission_evaluation
	WHERE mon_plan_id = mon_plan_id;
	
	--TABLES NOT IN WORKSPACE AND NEED TO WORK OUT SUPPLEMENTAL TABLES PIECE
	/*
	camdecmpswks.component_op_supp_data
	camdecmpswks.daily_test_supp_data
	camdecmpswks.daily_test_system_supp_data
	camdecmpswks.last_qa_value_supp_data
	camdecmpswks.sampling_train_supp_data
	camdecmpswks.sorbent_trap_supp_data
	camdecmpswks.system_op_supp_data
	*/
END;
$BODY$;