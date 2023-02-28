-- Table: camdaux.bulk_file_log

-- DROP TABLE IF EXISTS camdaux.bulk_file_log;

CREATE TABLE IF NOT EXISTS camdaux.bulk_file_log
(
    job_id uuid NOT NULL,
    parent_job_id uuid NOT NULL,
    data_type character varying(100) COLLATE pg_catalog."default" NOT NULL,
    data_subtype character varying(100) COLLATE pg_catalog."default",
    year numeric(38,0),
    quarter numeric(38,0),
    state_cd character varying(2) COLLATE pg_catalog."default",
    prg_cd character varying(8) COLLATE pg_catalog."default",
    CONSTRAINT pk_bulk_file_log PRIMARY KEY (job_id),
    CONSTRAINT fk_bulk_file_log_job_log FOREIGN KEY (job_id)
        REFERENCES camdaux.job_log (job_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_bulk_file_log_parent_job_log FOREIGN KEY (parent_job_id)
        REFERENCES camdaux.job_log (job_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_bulk_file_log_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_bulk_file_log_rpt_period FOREIGN KEY (quarter, year)
        REFERENCES camdecmpsmd.reporting_period (quarter, calendar_year) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_bulk_file_log_state_code FOREIGN KEY (state_cd)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- Index: idx_bulk_file_log_data_subtype

-- DROP INDEX camdaux.idx_bulk_file_log_data_subtype;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_data_subtype
    ON camdaux.bulk_file_log USING btree
    (data_subtype COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_bulk_file_log_data_type

-- DROP INDEX camdaux.idx_bulk_file_log_data_type;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_data_type
    ON camdaux.bulk_file_log USING btree
    (data_type COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_bulk_file_log_prg_cd

-- DROP INDEX camdaux.idx_bulk_file_log_prg_cd;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_prg_cd
    ON camdaux.bulk_file_log USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_bulk_file_log_quarter

-- DROP INDEX camdaux.idx_bulk_file_log_quarter;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_quarter
    ON camdaux.bulk_file_log USING btree
    (quarter ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_bulk_file_log_state_cd

-- DROP INDEX camdaux.idx_bulk_file_log_state_cd;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_state_cd
    ON camdaux.bulk_file_log USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_bulk_file_log_year

-- DROP INDEX camdaux.idx_bulk_file_log_year;

CREATE INDEX IF NOT EXISTS idx_bulk_file_log_year
    ON camdaux.bulk_file_log USING btree
    (year ASC NULLS LAST)
    TABLESPACE pg_default;