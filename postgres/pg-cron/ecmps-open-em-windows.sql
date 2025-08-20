CREATE EXTENSION IF NOT EXISTS pg_cron;

DO $$
DECLARE
	vJobId 		 bigint;
	vDatabase 	 text := 'replace with DB name';	
BEGIN
        SELECT cron.schedule(
		'Open Emissions Submission Windows for 2024 Q3 thru the latest reporting period',
		'0 * * * *',--every hour on the hour
		'select camdecmpsaux.open_beta_em_submission_windows();'
	) INTO vJobId;

	UPDATE cron.job SET database = vDatabase WHERE jobid = vJobId;
END $$;

--SELECT * FROM cron.job;
--SELECT * FROM cron.job_run_details order by end_time desc;
--SELECT * FROM cron.job_run_details WHERE status = 'failed';
--SELECT cron.unschedule('Open Emissions Submission Windows for 2024 Q3 thru the latest reporting period');
