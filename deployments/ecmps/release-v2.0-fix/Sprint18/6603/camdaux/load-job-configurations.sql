insert 
  into  camdaux.job_configuration 
        (job_type, job_group, job_name, job_description, trigger_name, trigger_description, cron_expression, active, run_once, run_at)
values  ('PdemJobQueue', 'MAINTAINANCE', 'Program Data Emissions Job Queue', 'Operates on an interval to determine if emission reports in PDEM_REPORT table need to be generated.', 'Check PDEM report queue every minute', 'Operate every minute to determine if there are PDEM reports which can be triggered for generation', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL);

