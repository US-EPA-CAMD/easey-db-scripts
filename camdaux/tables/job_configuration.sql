CREATE TABLE IF NOT EXISTS camdaux.job_configuration (
    job_class text PRIMARY KEY,
    cron_expression text,
    active boolean NOT NULL DEFAULT TRUE,
    run_once boolean DEFAULT FALSE,
    run_at timestamp without time zone
);

COMMENT ON COLUMN camdaux.job_configuration.job_class IS 'Indicates the class name that implements the job';

COMMENT ON COLUMN camdaux.job_configuration.run_once IS 'Flag to run the job as a one-shot. If `run_at` is set, the job will run at that time. Otherwise, the job will run immediately. This has no effect on the configured cron schedule.';

COMMENT ON COLUMN camdaux.job_configuration.run_at IS 'If `run_once` is true, specifies the time at which the job should run. This has no effect on the configured cron schedule.';

