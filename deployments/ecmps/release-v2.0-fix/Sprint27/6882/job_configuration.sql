ALTER TABLE camdaux.job_configuration
    DROP COLUMN IF EXISTS job_name;

ALTER TABLE camdaux.job_configuration
    DROP COLUMN IF EXISTS job_description;

ALTER TABLE camdaux.job_configuration
    DROP COLUMN IF EXISTS job_group;

ALTER TABLE camdaux.job_configuration
    DROP COLUMN IF EXISTS trigger_name;

ALTER TABLE camdaux.job_configuration
    DROP COLUMN IF EXISTS trigger_description;

ALTER TABLE camdaux.job_configuration RENAME COLUMN job_type TO job_class;

