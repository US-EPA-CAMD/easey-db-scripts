-- PROCEDURE: camdecmpswks.delete_emissions_workspace()

-- DROP PROCEDURE camdecmpswks.delete_emissions_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_emissions_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE TABLE camdecmpswks.component_op_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.daily_test_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.daily_test_system_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.last_qa_value_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.sampling_train_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.sorbent_trap_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.system_op_supp_data CASCADE;
	TRUNCATE TABLE camdecmpswks.sorbent_trap CASCADE;
	TRUNCATE TABLE camdecmpswks.hrly_op_data CASCADE;
	TRUNCATE TABLE camdecmpswks.summary_value CASCADE;
	TRUNCATE TABLE camdecmpswks.nsps4t_summary CASCADE;
	TRUNCATE TABLE camdecmpswks.daily_emission CASCADE;
	TRUNCATE TABLE camdecmpswks.daily_test_summary CASCADE;
	TRUNCATE TABLE camdecmpswks.weekly_test_summary CASCADE;
	TRUNCATE TABLE camdecmpswks.long_term_fuel_flow CASCADE;
	TRUNCATE TABLE camdecmpswks.emission_evaluation CASCADE;
END;
$BODY$;
