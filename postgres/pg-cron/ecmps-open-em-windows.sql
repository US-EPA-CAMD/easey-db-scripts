CREATE EXTENSION IF NOT EXISTS pg_cron;

DO $$
DECLARE
	vJobId bigint;
	vrptperiodid numeric := 123;
	vDatabase text := 'REPLACE WITH DB NAME';
BEGIN

	SELECT cron.schedule(
		'Open 2023 Q3 Emissions Window',
		'0 * * * *',--every hour on the hour
'INSERT INTO camdecmpsaux.em_submission_access(
	mon_plan_id,
	rpt_period_id,
	access_begin_date,
	access_end_date,
	em_sub_type_cd,
	resub_explanation,
	userid,
	add_date,
	update_date,
	em_status_cd,
	sub_availability_cd
)
SELECT
	mon_plan_id,
	' || vrptperiodid || ',
	CURRENT_DATE,
	CURRENT_DATE + interval ''30 days'',
	''RQRESUB'',
	''opening window for ecmps 2.0 BETA testing'',
	''WINMGMT'',
	current_timestamp,
	current_timestamp,
	''APPRVD'',
	''REQUIRE''
FROM camdecmps.monitor_plan
WHERE end_rpt_period_id IS NULL
AND mon_plan_id NOT IN (
	SELECT DISTINCT mon_plan_id
	FROM camdecmpsaux.em_submission_access
	WHERE rpt_period_id = ' || vrptperiodid || '
	AND em_status_cd IN (''PENDING'',''APPRVD'')
	AND sub_availability_cd IN (''GRANTED'',''REQUIRE'')
);'
	) INTO vJobId;

	UPDATE cron.job SET database = vDatabase WHERE jobid = vJobId;
END $$;

--SELECT * FROM cron.job;
--SELECT * FROM cron.job_run_details order by end_time desc;
--SELECT * FROM cron.job_run_details WHERE status = 'failed';
--SELECT cron.unschedule('Open 2023 Q3 Emissions Window');