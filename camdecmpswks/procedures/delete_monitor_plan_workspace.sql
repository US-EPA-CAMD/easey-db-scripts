-- PROCEDURE: camdecmpswks.delete_monitor_plan_workspace()

DROP PROCEDURE IF EXISTS camdecmpswks.delete_monitor_plan_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_workspace(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	TRUNCATE TABLE camdecmpswks.monitor_location CASCADE;
	TRUNCATE TABLE camdecmpswks.monitor_plan CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_capacity CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_control CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_fuel CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_stack_configuration CASCADE;
	TRUNCATE TABLE camdecmpswks.stack_pipe CASCADE;
END;
$BODY$;
