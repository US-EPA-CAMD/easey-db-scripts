CREATE EXTENSION IF NOT EXISTS pg_cron;

DO $$
DECLARE
	vJobId bigint;
	vDatabase text := 'REPLACE WITH DB NAME';
BEGIN
	SELECT cron.schedule(
		'User Checkout & Session Maintenance',
		'* * * * *',--every minute
		'CALL camdecmpswks.user_session_maintenance()'
	) INTO vJobId;

	UPDATE cron.job SET database = vDatabase WHERE jobid = vJobId;
END $$;

--SELECT * FROM cron.job;
--SELECT * FROM cron.job_run_details order by end_time desc;
--SELECT * FROM cron.job_run_details WHERE status = 'failed';
--SELECT cron.unschedule('User Checkout & Session Maintenance');