-- PROCEDURE: camdecmpswks.delete_monitor_plan_workspace()

-- DROP PROCEDURE camdecmpswks.delete_monitor_plan_workspace();

CREATE OR REPLACE PROCEDURE camdecmpswks.delete_monitor_plan_workspace()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
	TRUNCATE TABLE camdecmpswks.monitor_location CASCADE;
	TRUNCATE TABLE camdecmpswks.monitor_plan CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_capacity CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_control CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_fuel CASCADE;
	TRUNCATE TABLE camdecmpswks.unit_stack_configuration CASCADE;
	TRUNCATE TABLE camdecmpswks.stack_pipe CASCADE;
	TRUNCATE TABLE camdecmpswks.unit CASCADE;
END;
$procedure$
;
