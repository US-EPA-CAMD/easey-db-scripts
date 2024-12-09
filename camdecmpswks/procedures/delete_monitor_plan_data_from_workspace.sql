-- PROCEDURE: camdecmpswks.delete_monitor_plan_data_from_workspace(text)

-- DROP PROCEDURE IF EXISTS camdecmpswks.delete_monitor_plan_data_from_workspace(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_data_from_workspace(
	IN monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	unitIds   			int[];
	monLocIds 			text[];
    otherMpMonLocIds    text[];
	stackPipeIds		text[];
	unitStackConfigIds  text[];
BEGIN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

    SELECT ARRAY(
        SELECT mon_loc_id FROM camdecmpswks.monitor_plan_location mpl
        JOIN camdecmpswks.monitor_plan mp ON mpl.mon_plan_id = mp.mon_plan_id
        WHERE mp.fac_id IN (
            SELECT fac_id FROM camdecmpswks.monitor_plan
            WHERE mon_plan_id = monPlanId )
        AND mpl.mon_plan_id != monPlanId
    ) INTO otherMpMonLocIds;
	
	SELECT ARRAY(
		SELECT unit_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND unit_id IS NOT NULL
	) INTO unitIds;
	
	SELECT ARRAY(
	      select  Stack_Pipe_Id
            from  camdecmpswks.MONITOR_PLAN_LOCATION mpl
            join  camdecmpswks.MONITOR_LOCATION loc
                  on loc.Mon_Loc_Id = mpl.Mon_Loc_Id
                  and loc.Stack_Pipe_Id is not null
              where  mpl.Mon_Plan_Id = MonPlanId		
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
    AND mon_loc_id != ALL(otherMpMonLocIds);

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

    -- Delete any stack pipes that are not used in any other monitor plan.
	DELETE FROM camdecmpswks.stack_pipe stp
	 WHERE stp.stack_pipe_id = ANY(stackPipeIds)
	  and  not exists
        ( select  1 from  camdecmpswks.MONITOR_LOCATION loc
             where  loc.Stack_Pipe_Id = stp.Stack_Pipe_Id
        );
 

END;
$BODY$;
