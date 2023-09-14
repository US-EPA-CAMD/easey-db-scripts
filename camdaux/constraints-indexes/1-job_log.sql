ALTER TABLE IF EXISTS camdaux.job_log
    ADD CONSTRAINT pk_job_log PRIMARY KEY (job_id);

CREATE INDEX IF NOT EXISTS idx_job_log_job_class
    ON camdaux.job_log USING btree
    (job_class COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_job_log_job_name
    ON camdaux.job_log USING btree
    (job_name COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_job_log_job_system
    ON camdaux.job_log USING btree
    (job_system COLLATE pg_catalog."default" ASC NULLS LAST);

CREATE INDEX IF NOT EXISTS idx_job_log_status_cd
    ON camdaux.job_log USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST);
