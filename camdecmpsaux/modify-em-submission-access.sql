DO $$
DECLARE
	startVal bigint;
	sqlStatement text;
BEGIN
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_progress;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_expected;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_received;
	DROP VIEW IF EXISTS camdecmps.vw_emissions_submissions_gdm;
	SELECT MAX(em_sub_access_id)+1 FROM camdecmpsaux.em_submission_access INTO startVal;
	ALTER TABLE camdecmpsaux.em_submission_access
		ALTER COLUMN em_sub_access_id TYPE bigint;
	sqlStatement := format('
	ALTER TABLE camdecmpsaux.em_submission_access
		ALTER COLUMN em_sub_access_id ADD GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START %s MINVALUE 1 MAXVALUE 999999999999 );
	', startVal);
	RAISE NOTICE 'Executing...%', sqlStatement;
	EXECUTE sqlStatement;
END $$;