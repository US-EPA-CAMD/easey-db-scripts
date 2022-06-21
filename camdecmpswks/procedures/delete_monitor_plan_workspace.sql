-- PROCEDURE: camdecmpswks.delete_monitor_plan_workspace()

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
		-- CHECK_SESSION --
		TRUNCATE TABLE camdecmpswks.check_session CASCADE;

		-- MONITOR_LOCATION --
		TRUNCATE TABLE camdecmpswks.monitor_location CASCADE;
		
		-- MONITOR_PLAN --
		TRUNCATE TABLE camdecmpswks.monitor_plan CASCADE;

		-- UNIT_CAPACITY --
		TRUNCATE TABLE camdecmpswks.unit_capacity CASCADE;

		-- UNIT_CONTROL --
		TRUNCATE TABLE camdecmpswks.unit_control CASCADE;

		-- UNIT_FUEL --
		TRUNCATE TABLE camdecmpswks.unit_fuel CASCADE;

		-- UNIT_STACK_CONFIGURATION --
		TRUNCATE TABLE camdecmpswks.unit_stack_configuration CASCADE;

		-- STACK_PIPE --
		TRUNCATE TABLE camdecmpswks.stack_pipe CASCADE;
END;
$BODY$;
