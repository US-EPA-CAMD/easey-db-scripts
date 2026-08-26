INSERT INTO camdaux.job_configuration (job_class, cron_expression, active, run_once, run_at)
    VALUES ('BulkImportJobQueue', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL);

