DROP PROCEDURE IF EXISTS camdecmps.delete_monitor_plan_emissions_data_from_global(text, numeric);

CREATE OR REPLACE PROCEDURE camdecmps.delete_monitor_plan_emissions_data_from_global(
	monplanid text,
	rptperiodid numeric)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
BEGIN

	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmps.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	DELETE FROM camdecmps.emission_evaluation
	WHERE mon_plan_id = monPlanId and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.sorbent_trap
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.hrly_op_data
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.summary_value
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.nsps4t_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.daily_emission
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.daily_backstop
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.daily_test_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.weekly_test_summary
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;

	DELETE FROM camdecmps.long_term_fuel_flow
	WHERE mon_loc_id = ANY(monLocIds) and rpt_period_id = rptperiodid;
END;
$BODY$;