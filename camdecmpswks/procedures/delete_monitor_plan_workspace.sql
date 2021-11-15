-- PROCEDURE: camdecmpswks.delete_monitor_plan_workspace()

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
		-- UNIT_STACK_CONFIGURATION --
		DELETE FROM camdecmpswks.unit_stack_configuration;

		-- ANALYZER_RANGE --
		DELETE FROM camdecmpswks.analyzer_range;		
		
		-- MONITOR_SYSTEM_COMPONENT --
		DELETE FROM camdecmpswks.monitor_system_component;
		
		-- COMPONENT --
		DELETE FROM camdecmpswks.component;		
		
		-- MATS_METHOD_DATA --
		DELETE FROM camdecmpswks.mats_method_data;

		-- MONITOR_DEFAULT --
		DELETE FROM camdecmpswks.monitor_default;

		-- MONITOR_FORMULA --
		DELETE FROM camdecmpswks.monitor_formula;

		-- MONITOR_LOAD --
		DELETE FROM camdecmpswks.monitor_load;

		-- MONITOR_LOCATION_ATTRIBUTE --
		DELETE FROM camdecmpswks.monitor_location_attribute;

		-- MONITOR_METHOD --
		DELETE FROM camdecmpswks.monitor_method;

		-- MONITOR_QUALIFICATION_LEE --
		DELETE FROM camdecmpswks.monitor_qualification_lee;

		-- MONITOR_QUALIFICATION_LME --		
		DELETE FROM camdecmpswks.monitor_qualification_lme;		

		-- MONITOR_QUALIFICATION_PCT --		
		DELETE FROM camdecmpswks.monitor_qualification_pct;		

		-- MONITOR_QUALIFICATION --
		DELETE FROM camdecmpswks.monitor_qualification;

		-- MONITOR_SPAN --
		DELETE FROM camdecmpswks.monitor_span;

		-- SYSTEM_FUEL_FLOW --
		DELETE FROM camdecmpswks.system_fuel_flow;

		-- MONITOR_SYSTEM --
		DELETE FROM camdecmpswks.monitor_system;

		-- RECT_DUCT_WAF --
		DELETE FROM camdecmpswks.rect_duct_waf;

		-- MONITOR_PLAN_LOCATION --
		DELETE FROM camdecmpswks.monitor_plan_location;

		-- MONITOR_LOCATION --
		DELETE FROM camdecmpswks.monitor_location;
		
		-- MONITOR_PLAN_COMMENT --
		DELETE FROM camdecmpswks.monitor_plan_comment;		

		-- MONITOR_PLAN_REPORTING_FREQ --
		DELETE FROM camdecmpswks.monitor_plan_reporting_freq;

		-- MONITOR_PLAN --
		DELETE FROM camdecmpswks.monitor_plan;

		-- STACK_PIPE --
		DELETE FROM camdecmpswks.stack_pipe;

		-- UNIT_CAPACITY --
		DELETE FROM camdecmpswks.unit_capacity;

		-- UNIT_CONTROL --
		DELETE FROM camdecmpswks.unit_control;

		-- UNIT_FUEL --
		DELETE FROM camdecmpswks.unit_fuel;		
END;
$BODY$;
