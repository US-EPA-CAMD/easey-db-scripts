-- Table: camdaux.job_log

-- DROP TABLE camdaux.job_log;

CREATE TABLE IF NOT EXISTS camdaux.job_log
(
    job_id uuid NOT NULL,
    job_system character varying COLLATE pg_catalog."default" NOT NULL,
    job_class character varying COLLATE pg_catalog."default" NOT NULL,
    job_name character varying COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL DEFAULT timezone('est'::text, CURRENT_TIMESTAMP),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    status_cd character varying(8) COLLATE pg_catalog."default" DEFAULT 'QUEUED'::character varying,
    additional_details character varying COLLATE pg_catalog."default",
    CONSTRAINT pk_job_log PRIMARY KEY (job_id)
);
-- Index: idx_job_log_job_class

-- DROP INDEX camdaux.idx_job_log_job_class;

CREATE INDEX idx_job_log_job_class
    ON camdaux.job_log USING btree
    (job_class COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_job_log_job_name

-- DROP INDEX camdaux.idx_job_log_job_name;

CREATE INDEX idx_job_log_job_name
    ON camdaux.job_log USING btree
    (job_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_job_log_job_system

-- DROP INDEX camdaux.idx_job_log_job_system;

CREATE INDEX idx_job_log_job_system
    ON camdaux.job_log USING btree
    (job_system COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_job_log_status_cd

-- DROP INDEX camdaux.idx_job_log_status_cd;

CREATE INDEX idx_job_log_status_cd
    ON camdaux.job_log USING btree
    (status_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;