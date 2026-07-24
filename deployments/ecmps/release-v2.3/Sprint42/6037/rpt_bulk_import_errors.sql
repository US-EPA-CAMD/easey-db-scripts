-- FUNCTION: camdecmpswks.rpt_bulk_import_errors(bigint)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_bulk_import_errors(bigint) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_bulk_import_errors(
	importid bigint)
    RETURNS TABLE("errorMessage" text)
    LANGUAGE 'sql'

    COST 100
    VOLATILE
    ROWS 1000

AS $BODY$
	SELECT btrim(err.msg) AS "errorMessage"
	FROM camdecmpsaux.import_queue iq
	CROSS JOIN LATERAL unnest(string_to_array(iq.note, E'\n')) AS err(msg)
	WHERE iq.import_id = importId
	  AND iq.note IS NOT NULL
	  AND btrim(err.msg) <> '';
$BODY$;
