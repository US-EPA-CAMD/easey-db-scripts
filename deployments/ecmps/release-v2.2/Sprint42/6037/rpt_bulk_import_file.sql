-- FUNCTION: camdecmpswks.rpt_bulk_import_file(bigint)

DROP FUNCTION IF EXISTS camdecmpswks.rpt_bulk_import_file(bigint) CASCADE;

CREATE OR REPLACE FUNCTION camdecmpswks.rpt_bulk_import_file(
	importid bigint)
    RETURNS TABLE("fileName" text, "fileType" text, "unitStackPipe" text, "reportingPeriod" text, "status" text)
    LANGUAGE 'sql'

    COST 100
    VOLATILE
    ROWS 1000

AS $BODY$
	SELECT
		iq.file_name AS "fileName",
		iq.file_type_cd AS "fileType",
		(
			SELECT string_agg(
				CASE WHEN ml.unit_id IS NULL THEN sp.stack_name ELSE u.unitid END,
				', ' ORDER BY u.unitid, sp.stack_name
			)
			FROM camdecmpswks.monitor_plan_location mpl
			JOIN camdecmpswks.monitor_location ml USING(mon_loc_id)
			LEFT JOIN camdecmpswks.stack_pipe sp USING(stack_pipe_id)
			LEFT JOIN camd.unit u USING(unit_id)
			WHERE mpl.mon_plan_id = iq.mon_plan_id
		) AS "unitStackPipe",
		CASE WHEN rp.calendar_year IS NOT NULL
			 THEN rp.calendar_year || ' Q' || rp.quarter
			 ELSE '' END AS "reportingPeriod",
		iq.status_cd AS "status"
	FROM camdecmpsaux.import_queue iq
	LEFT JOIN camdecmpsmd.reporting_period rp ON rp.rpt_period_id = iq.rpt_period_id
	WHERE iq.import_id = importId;
$BODY$;
