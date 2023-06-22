-- PROCEDURE: cron.job_run_detail_maintenance()

DROP PROCEDURE IF EXISTS cron.job_run_detail_maintenance();

CREATE OR REPLACE PROCEDURE cron.job_run_detail_maintenance(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM cron.job_run_details
	WHERE (
		end_time IS NULL AND start_time + interval '30 days' < current_timestamp
	) OR (
		end_time IS NOT NULL AND end_time + interval '30 days' < current_timestamp
	);
END
$BODY$;

DO $$
DECLARE
	vJobId bigint;
	vDatabase text := 'cgawsbrokerprodr97macy19l';
BEGIN
	SELECT cron.schedule(
		'Job Run Details Maintenance',
		'0 0 * * *',
		'CALL cron.job_run_detail_maintenance()'
	) INTO vJobId;

	SELECT cron.schedule(
		'User Checkout & Session Maintenance',
		'* * * * *',
		'CALL camdecmpswks.user_session_maintenance()'
	) INTO vJobId;

	UPDATE cron.job SET database = vDatabase WHERE jobid = vJobId;
END $$;

--SELECT * FROM cron.job;
--SELECT * FROM cron.job_run_details order by end_time desc;
--SELECT * FROM cron.job_run_details WHERE status = 'failed';

--SELECT cron.unschedule('Job Run Details Maintenance');
--SELECT cron.unschedule('User Checkout & Session Maintenance');

--call cron.job_run_detail_maintenance()

