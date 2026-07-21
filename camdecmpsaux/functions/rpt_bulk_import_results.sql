-- FUNCTION: camdecmpsaux.rpt_bulk_import_results(bigint)

DROP FUNCTION IF EXISTS camdecmpsaux.rpt_bulk_import_results(bigint) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpsaux.rpt_bulk_import_results(
	importid bigint)
    RETURNS TABLE("fileName" text, "orisCode" numeric, "fileType" text, "reportingPeriod" text, "status" text, "note" text)
    LANGUAGE 'sql'

    COST 100
    VOLATILE
    ROWS 1000

AS $BODY$
	SELECT
		iq.file_name AS "fileName",
		iq.oris_code AS "orisCode",
		iq.file_type_cd AS "fileType",
		CASE WHEN rp.calendar_year IS NOT NULL
			 THEN rp.calendar_year || ' Q' || rp.quarter
			 ELSE '' END AS "reportingPeriod",
		iq.status_cd AS "status",
		iq.note AS "note"
	FROM camdecmpsaux.import_queue iq
	LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = iq.rpt_period_id
	WHERE iq.import_id = importId;
$BODY$;
