-- PROCEDURE: camdecmpswks.delete_monitor_plan_from_workspace(text)

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_data_from_workspace(
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

    -- Delete any monitor locations that are not used in any other monitor plan.
	DELETE FROM camdecmpswks.monitor_location
	WHERE mon_loc_id = ANY(monLocIds)
    AND mon_loc_id NOT IN (
        SELECT mon_loc_id FROM camdecmpswks.monitor_plan_location mpl
        JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id = mp.mon_plan_id
        WHERE mp.fac_id IN (
            SELECT fac_id
            FROM camdecmpswks.monitor_plan
            WHERE mon_plan_id = monPlanId
        )
        AND mpl.mon_plan_id != monPlanId
    );

	DELETE FROM camdecmpswks.monitor_plan
	WHERE mon_plan_id = monPlanId;

    DELETE FROM camdecmpswks.unit
    WHERE unit_id = ANY(unitIds);

	DELETE FROM camdecmpswks.unit_capacity
	WHERE unit_id = ANY(unitIds);

	DELETE FROM camdecmpswks.unit_control
	WHERE unit_id = ANY(unitIds);

	DELETE FROM camdecmpswks.unit_fuel
	WHERE unit_id = ANY(unitIds);

	DELETE FROM camdecmpswks.unit_stack_configuration
	WHERE config_id = ANY(unitStackConfigIds);

	DELETE FROM camdecmpswks.stack_pipe
	WHERE stack_pipe_id = ANY(stackPipeIds);
END;
$BODY$;
