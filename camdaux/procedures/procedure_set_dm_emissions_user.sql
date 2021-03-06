-- PROCEDURE: camdaux.procedure_set_dm_emissions_user()

-- DROP PROCEDURE camdaux.procedure_set_dm_emissions_user();

CREATE OR REPLACE PROCEDURE camdaux.procedure_set_dm_emissions_user(
	)
LANGUAGE 'sql'
AS $BODY$
SET timezone = 'America/New_York';

INSERT INTO camdecmps.dm_emissions_user(
	dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date)
SELECT dme.dm_emissions_id, 'S3BDF',now()::timestamp, now()::timestamp, null, null
   FROM camdecmps.dm_emissions dme
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camdecmps.monitor_plan mp USING (mon_plan_id)
	JOIN camd.plant p USING (fac_id)
$BODY$;
