-- PROCEDURE: camdaux.procedure_bulk_file_requeue_check()

DROP PROCEDURE IF EXISTS camdaux.procedure_bulk_file_requeue_check();

CREATE OR REPLACE PROCEDURE camdaux.procedure_bulk_file_requeue_check(
	)
LANGUAGE 'sql'
AS $BODY$
SET timezone = 'America/New_York';

update camdaux.bulk_file_queue bfq
set status_cd = 'QUEUED'
where bfq.status_cd::text = 'ERROR'::text OR bfq.status_cd::text = 'WIP'::text AND timezone('est'::text, CURRENT_TIMESTAMP) >= (bfq.start_date + '24:00:00'::interval)
$BODY$;
