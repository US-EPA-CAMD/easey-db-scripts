-- PROCEDURE: camdecmpswks.delete_monitor_plan_data_from_workspace(text)

-- DROP PROCEDURE IF EXISTS camdecmpswks.delete_monitor_plan_data_from_workspace(text);

/****************************************************************************************************************************************************
    Maintenance History:
    
    Date        Programmer      Ticket      Description
    ----------  --------------  ----------  ---------------------------------------------------------------------------------------------------------
    2026-07-10  Dwayne Whitten  #7202       Removed the deletion of camdecmpswks.UNIT rows, which are not really MP rows.
****************************************************************************************************************************************************/
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
	
    -- Delete monitor location children for locations that are used in other monitor plans.
	-- Helps ensure that workspace only monitor location children are deleted from the workspace.
	DELETE FROM camdecmpswks.MATS_METHOD_DATA 			 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);	
	DELETE FROM camdecmpswks.MONITOR_DEFAULT 			 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);	
	DELETE FROM camdecmpswks.MONITOR_FORMULA 			 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.MONITOR_LOAD 				 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.MONITOR_LOCATION_ATTRIBUTE  WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.MONITOR_METHOD 			 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.MONITOR_QUALIFICATION 		 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.MONITOR_SPAN 				 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);
	DELETE FROM camdecmpswks.RECT_DUCT_WAF 				 WHERE mon_loc_id = ANY(monLocIds) AND mon_loc_id = ANY(otherMpMonLocIds);  
	
    -- Delete component or system for locations that are used in other monitor plans and are not used in supplemental data.
	-- The supplemental data for the target MP should have been deleted by delete_monitor_plan_emissions_data_from_workspace.
	-- If supplemental data exists for another MP, the coponent or system should not be new.
	-- Helps ensure that workspace only monitor location children are deleted from the workspace.
	DELETE 
      FROM 	camdecmpswks.COMPONENT dat
     WHERE  mon_loc_id = ANY(monLocIds)
       AND 	mon_loc_id = ANY(otherMpMonLocIds)
       AND  NOT EXISTS
			( 
				SELECT 	1
				  FROM 	camdecmpswks.COMPONENT_OP_SUPP_DATA exs
				 WHERE 	exs.COMPONENT_ID = dat.COMPONENT_ID
			);
	DELETE
      FROM 	camdecmpswks.MONITOR_SYSTEM dat
     WHERE  mon_loc_id = ANY(monLocIds)
       AND 	mon_loc_id = ANY(otherMpMonLocIds)
       AND  NOT EXISTS
			( 
				SELECT 	1
				  FROM 	camdecmpswks.SYSTEM_OP_SUPP_DATA exs
				 WHERE 	exs.MON_SYS_ID = dat.MON_SYS_ID
			);
    

	DELETE FROM camdecmpswks.monitor_plan
	WHERE mon_plan_id = monPlanId;

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
