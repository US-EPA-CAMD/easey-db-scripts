DELETE FROM camdaux.job_configuration
WHERE job_type = 'SubmissionWindowManagement';

INSERT INTO camdaux.job_configuration (job_type, job_group, job_name, job_description, trigger_name, trigger_description, cron_expression, active, run_once, run_at)
    VALUES ('SubmissionWindowManagement', 'MAINTAINANCE', 'Submission Window Management', 'Manages emission submission windows', 'Submission Window Management Trigger', 'Runs daily at 3AM to initialize and close emission submission access', '0 0 3 ? * * *', TRUE, FALSE, NULL);

DELETE FROM camdaux.job_configuration
WHERE job_type IN ('SubmissionReminderProcessQueue', 'SubmissionWindowProcessQueue');