DELETE FROM camdaux.job_configuration
WHERE job_type = 'EvaluationJobQueue';

INSERT INTO camdaux.job_configuration (job_type, job_group, job_name, job_description, trigger_name, trigger_description, cron_expression, active, run_once, run_at)
    VALUES ('EvaluationJobQueue', 'MAINTAINANCE', 'Evaluation Job Queue', 'Operates on an interval to determine if files in evaluation queue can be triggered.', 'Evaluation Job Queue Trigger', 'Operate every 15 seconds to determine if there are files in evaluation queue which can be triggered', '*/15 * * * * ? *', TRUE, FALSE, NULL);

