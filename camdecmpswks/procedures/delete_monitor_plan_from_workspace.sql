-- PROCEDURE: camdecmpswks.delete_monitor_plan_from_workspace(text)

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_from_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_from_workspace(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	unitIds   			int[];
	monLocIds 			text[];
	stackPipeIds		text[];
	unitStackConfigIds  text[];
BEGIN

	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;
	
	SELECT ARRAY(
		SELECT unit_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND unit_id IS NOT NULL
	) INTO unitIds;
	
	SELECT ARRAY(
		SELECT stack_pipe_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND stack_pipe_id IS NOT NULL
	) INTO stackPipeIds;

	SELECT ARRAY(
		SELECT config_id
		FROM camdecmpswks.unit_stack_configuration
		WHERE unit_id = ANY(unitIds)
		OR stack_pipe_id = ANY(stackPipeIds)
	) INTO unitStackConfigIds;

	-- CHECK_SESSION --
	DELETE FROM camdecmpswks.check_session
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_LOCATION --
	DELETE FROM camdecmpswks.monitor_location
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_PLAN --
	DELETE FROM camdecmpswks.monitor_plan
	WHERE mon_plan_id = monPlanId;
	
	-- UNIT_CAPACITY --
	DELETE FROM camdecmpswks.unit_capacity
	WHERE unit_id = ANY(unitIds);

	-- UNIT_CONTROL --
	DELETE FROM camdecmpswks.unit_control
	WHERE unit_id = ANY(unitIds);

	-- UNIT_FUEL --
	DELETE FROM camdecmpswks.unit_fuel
	WHERE unit_id = ANY(unitIds);

	-- UNIT_STACK_CONFIGURATION --
	DELETE FROM camdecmpswks.unit_stack_configuration
	WHERE config_id = ANY(unitStackConfigIds);

	-- STACK_PIPES --
	DELETE FROM camdecmpswks.stack_pipe
	WHERE stack_pipe_id = ANY(stackPipeIds);

END;
$BODY$;
