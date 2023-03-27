DO $$
DECLARE
	vJobId bigint;
BEGIN
	SELECT cron.schedule(
		'Delete expired user sessions',
		'0,5,10,15,20,25,30,35,40,45,50,55 * * * *',
		'delete from camdecmpswks.user_session where last_activity + interval ''20 mins'' < current_timestamp'
	) INTO vJobId;

	UPDATE cron.job SET database = 'cgawsbrokerprodr97macy19l' WHERE jobid = vJobId;
END $$;

--SELECT * FROM cron.job;
--SELECT * FROM cron.job_run_details;
--SELECT * FROM cron.job_run_details WHERE status = 'failed';
--SELECT cron.unschedule('Delete expired user sessions')