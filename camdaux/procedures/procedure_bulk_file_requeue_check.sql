-- PROCEDURE: camdaux.procedure_bulk_file_requeue_check()

-- DROP PROCEDURE IF EXISTS camdaux.procedure_bulk_file_requeue_check();

CREATE OR REPLACE PROCEDURE camdaux.procedure_bulk_file_requeue_check(
	)
LANGUAGE 'sql'
AS $BODY$
SET timezone = 'America/New_York';

update camdaux.job_log jl
set status_cd = 'QUEUED'
where jl.status_cd::text = 'ERROR'::text OR (jl.status_cd::text = 'QUEUED'::text OR jl.status_cd::text = 'WIP'::text) AND timezone('est'::text, CURRENT_TIMESTAMP) >= (jl.add_date + '24:00:00'::interval)
			
$BODY$;
