TRUNCATE camdaux.job_configuration;

INSERT INTO camdaux.job_configuration (job_class, cron_expression, active, run_once, run_at)
    VALUES ('AllowanceComplianceBulkDataFiles', '0 0/10 2-4 15 * ? *', TRUE, FALSE, NULL),
    ('AllowanceHoldingsBulkDataFiles', '0 0/10 2-4 ? * * *', TRUE, FALSE, NULL),
    ('AllowanceTransactionsBulkDataFiles', '0 0/10 2-4 15 1 ? *', TRUE, FALSE, NULL),
    ('ApportionedEmissionsBulkData', '0 0/10 4-6 ? * * *', TRUE, FALSE, NULL),
    ('BulkDataFileMaintenance', '0 0 6 ? * * *', TRUE, FALSE, NULL),
    ('BulkFileJobQueue', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL),
    ('EmailQueue', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL),
    ('EmissionsComplianceBulkDataFiles', '0 0/10 2-4 15 * ? *', TRUE, FALSE, NULL),
    ('EvaluationJobQueue', '*/15 * * * * ? *', TRUE, FALSE, NULL),
    ('FacilityAttributesBulkDataFiles', '0 0/10 2-4 ? * * *', TRUE, FALSE, NULL),
    ('InventoryChanges', '0 0/5 * * * ?', TRUE, FALSE, NULL),
    ('PdemJob', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL),
    ('SubmissionJobQueue', '0 0/1 * 1/1 * ? *', TRUE, FALSE, NULL),
    ('SubmissionWindowManagement', '0 0 3 ? * * *', TRUE, FALSE, NULL);
