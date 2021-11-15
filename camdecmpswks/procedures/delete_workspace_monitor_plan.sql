-- PROCEDURE: camdecmpswks.delete_workspace_monitor_plan(text)

-- DROP PROCEDURE camdecmpswks.delete_workspace_monitor_plan(text);

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_workspace_monitor_plan(
	monplanid text)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
	monLocIds 		text[];
	unitIds   		integer[];
	stackPipeIds	text[];	
BEGIN
	-- GET LIST OF LOCATION IDs IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT mon_loc_id
		FROM camdecmpswks.monitor_plan_location
		WHERE mon_plan_id = monPlanId
	) INTO monLocIds;

	-- GET LIST OF UNIT IDs FOR ALL LOCATIONS IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT unit_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND unit_id IS NOT NULL
	) INTO unitIds;
	
	-- GET LIST OF STACK PIPE IDs FOR ALL LOCATIONS IN THE MONITOR PLAN
	SELECT ARRAY(
		SELECT stack_pipe_id
		FROM camdecmpswks.monitor_location
		WHERE mon_loc_id = ANY(monLocIds)
		AND stack_pipe_id IS NOT NULL
	) INTO stackPipeIds;
	
	---------------------------------- MONITOR SYSTEM DEPENDENT DATA --------------------------------------------

	-- MONITOR_SYSTEM_COMPONENT --
	DELETE FROM camdecmpswks.monitor_system_component
	WHERE mon_sys_comp_id IN (
		SELECT mon_sys_comp_id
		FROM camdecmpswks.monitor_system_component	
		JOIN camdecmpswks.monitor_system
			USING(mon_sys_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	-- SYSTEM_FUEL_FLOW --
	DELETE FROM camdecmpswks.system_fuel_flow
	WHERE sys_fuel_id IN (
		SELECT sys_fuel_id
		FROM camdecmpswks.system_fuel_flow	
		JOIN camdecmpswks.monitor_system
			USING(mon_sys_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	---------------------------------- QUALIFICATION DEPENDENT DATA --------------------------------------------

	-- MONITOR_QUALIFICATION_LEE --
	DELETE FROM camdecmpswks.monitor_qualification_lee
	WHERE mon_qual_lee_id IN (
		SELECT mon_qual_lee_id
		FROM camdecmpswks.monitor_qualification_lee
		JOIN camdecmpswks.monitor_qualification
			USING (mon_qual_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	-- MONITOR_QUALIFICATION_LME --
	DELETE FROM camdecmpswks.monitor_qualification_lme
	WHERE mon_lme_id IN (
		SELECT mon_lme_id
		FROM camdecmpswks.monitor_qualification_lme
		JOIN camdecmpswks.monitor_qualification
			USING (mon_qual_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	-- MONITOR_QUALIFICATION_PCT --
	DELETE FROM camdecmpswks.monitor_qualification_pct
	WHERE mon_pct_id IN (
		SELECT mon_pct_id
		FROM camdecmpswks.monitor_qualification_pct
		JOIN camdecmpswks.monitor_qualification
			USING (mon_qual_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	---------------------------------- COMPONENT DEPENDENT DATA --------------------------------------------

	-- ANALYZER_RANGE --
	DELETE FROM camdecmpswks.analyzer_range
	WHERE analyzer_range_id IN (
		SELECT analyzer_range_id
		FROM camdecmpswks.analyzer_range
		JOIN camdecmpswks.component
			USING(component_id)
		WHERE mon_loc_id = ANY(monLocIds)
	);

	---------------------------------- LOCATION DEPENDENT DATA --------------------------------------------

	-- COMPONENT --
	DELETE FROM camdecmpswks.component
	WHERE mon_loc_id = ANY(monLocIds);

	-- MATS_METHOD_DATA --
	DELETE FROM camdecmpswks.mats_method_data
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_DEFAULT --
	DELETE FROM camdecmpswks.monitor_default
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_FORMULA --
	DELETE FROM camdecmpswks.monitor_formula
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_LOAD --
	DELETE FROM camdecmpswks.monitor_load
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_LOCATION_ATTRIBUTE --
	DELETE FROM camdecmpswks.monitor_location_attribute
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_METHOD --
	DELETE FROM camdecmpswks.monitor_method
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_QUALIFICATION --
	DELETE FROM camdecmpswks.monitor_qualification
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_SPAN --
	DELETE FROM camdecmpswks.monitor_span
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_SYSTEM --
	DELETE FROM camdecmpswks.monitor_system
	WHERE mon_loc_id = ANY(monLocIds);

	-- RECT_DUCT_WAF --
	DELETE FROM camdecmpswks.rect_duct_waf
	WHERE mon_loc_id = ANY(monLocIds);

	---------------------------------- MONITOR PLAN DEPENDENT DATA --------------------------------------------

	-- MONITOR_PLAN_COMMENT --
	DELETE FROM camdecmpswks.monitor_plan_comment
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_PLAN_REPORTING_FREQ --
	DELETE FROM camdecmpswks.monitor_plan_reporting_freq
	WHERE mon_plan_id = monPlanId;

	-- MONITOR_PLAN_LOCATION --
	DELETE FROM camdecmpswks.monitor_plan_location
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_LOCATION --
	DELETE FROM camdecmpswks.monitor_location
	WHERE mon_loc_id = ANY(monLocIds);

	-- MONITOR_PLAN --
	DELETE FROM camdecmpswks.monitor_plan
	WHERE mon_plan_id = monPlanId;
	
	---------------------------------- UNIT & STACK PIPE DEPENDENT DATA --------------------------------------------
	
	-- UNIT_CAPACITY --
	DELETE FROM camdecmpswks.unit_capacity
	WHERE unit_id = ANY (unitIds);

	-- UNIT_CONTROL --
	DELETE FROM camdecmpswks.unit_control
	WHERE unit_id = ANY (unitIds);

	-- UNIT_FUEL --
	DELETE FROM camdecmpswks.unit_fuel
	WHERE unit_id = ANY (unitIds);

	-- UNIT_STACK_CONFIGURATION --	
	DELETE FROM camdecmpswks.unit_stack_configuration
	WHERE unit_id = ANY (unitIds);

	-- STACK_PIPES --
	DELETE FROM camdecmpswks.stack_pipe
	WHERE stack_pipe_id = ANY(stackPipeIds);

END;
$BODY$;
