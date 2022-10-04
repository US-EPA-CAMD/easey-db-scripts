-- PROCEDURE: camdaux.procedure_set_dm_emissions_user()

-- DROP PROCEDURE IF EXISTS camdaux.procedure_set_dm_emissions_user();

CREATE OR REPLACE PROCEDURE camdaux.procedure_set_dm_emissions_user(
	)
LANGUAGE 'sql'
AS $BODY$
SET timezone = 'America/New_York';

INSERT INTO camdecmps.dm_emissions_user(
	dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date)
SELECT dme.dm_emissions_id, 'S3BDF',now()::timestamp, now()::timestamp, null, null
   FROM camdecmps.dm_emissions dme;		
$BODY$;