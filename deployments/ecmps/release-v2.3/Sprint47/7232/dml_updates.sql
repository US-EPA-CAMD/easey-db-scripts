-- JOB_CONFIGURATION
insert
  into  camdaux.job_configuration
        ( job_class, cron_expression, active, run_once, run_at )
values ( 'DataMartRefreshJob', '0 0 2 ? * * *', true, false, null );

commit;