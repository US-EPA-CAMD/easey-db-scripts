-- PROCEDURE: camdaux.procedure_set_dm_emissions_user()

DROP PROCEDURE IF EXISTS camdaux.procedure_set_dm_emissions_user();

CREATE OR REPLACE PROCEDURE camdaux.procedure_set_dm_emissions_user(
	)
LANGUAGE 'sql'
AS $BODY$
	SET timezone = 'America/New_York';
	
	INSERT INTO camdecmps.dm_emissions_user(
		dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date
	)
	SELECT
		dme.dm_emissions_id,
		'S3QTRFILES',
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
		'Quarterly bulk data files generation',
		CURRENT_TIMESTAMP
	FROM camdecmps.dm_emissions dme
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	LEFT JOIN camdecmps.dm_emissions_user dmeu
		ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text
		AND dmeu.dm_emissions_user_cd::text = 'S3QTRFILES'::text
	WHERE dmeu.dm_emissions_id IS NULL
	AND camdaux.can_generate_quarter(rp.quarter::integer, rp.calendar_year::integer);

	INSERT INTO camdecmps.dm_emissions_user(
		dm_emissions_id, dm_emissions_user_cd, process_date, complete_date, note, note_date
	)
	SELECT
		dme.dm_emissions_id,
		'S3STATEFILES',
		CURRENT_TIMESTAMP,
		CURRENT_TIMESTAMP,
		'Annual State bulk data files generation',
		CURRENT_TIMESTAMP
	FROM camdecmps.dm_emissions dme
	JOIN camdecmpsmd.reporting_period rp USING (rpt_period_id)
	JOIN camd.plant p USING (fac_id)
	LEFT JOIN camdecmps.dm_emissions_user dmeu
		ON dme.dm_emissions_id::text = dmeu.dm_emissions_id::text
		AND dmeu.dm_emissions_user_cd::text = 'S3STATEFILES'::text
	WHERE dmeu.dm_emissions_id IS NULL
	AND camdaux.can_generate_state(rp.calendar_year::integer);
$BODY$;
