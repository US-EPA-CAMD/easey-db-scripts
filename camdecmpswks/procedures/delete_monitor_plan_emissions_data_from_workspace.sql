CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_emissions_data_from_workspace(IN monplanid text, IN rptperiodid numeric)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
	monLocIds 		text[];
BEGIN

	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	DELETE FROM camdecmpswks.emission_evaluation
	WHERE mon_plan_id = monPlanId and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.sorbent_trap
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.hrly_op_data
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.summary_value
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.nsps4t_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.daily_emission
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.daily_backstop
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.daily_test_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.weekly_test_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmpswks.long_term_fuel_flow
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;
END;
$procedure$
;
