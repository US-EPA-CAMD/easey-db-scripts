-- Table: camdecmpsaux.program_parameter

-- DROP TABLE camdecmpsaux.program_parameter;

CREATE TABLE IF NOT EXISTS camdecmpsaux.program_parameter
(
    prg_param_id numeric(38,0) NOT NULL,
    prg_id numeric(38,0) NOT NULL,
    parameter_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    required_ind numeric(1,0) NOT NULL DEFAULT 0,
    begin_rpt_period_id numeric(38,0) NOT NULL,
    end_rpt_period_id numeric(38,0),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_program_parameter PRIMARY KEY (prg_param_id),
    CONSTRAINT uq_prg_param_begin UNIQUE (prg_id, parameter_cd, begin_rpt_period_id),
    CONSTRAINT fk_prg_param_begin_rpt_period FOREIGN KEY (begin_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_prg_param_end_rpt_period FOREIGN KEY (end_rpt_period_id)
        REFERENCES camdecmpsmd.reporting_period (rpt_period_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_prg_param_param_cd FOREIGN KEY (parameter_cd)
        REFERENCES camdecmpsmd.parameter_code (parameter_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_prg_param_prg_id FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdecmpsaux.program_parameter
    IS 'Stores the relationship between a program and the pollutant parameters that are required to be reported for that program.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.prg_param_id
    IS 'PROGRAM PARAMETER identity key.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.prg_id
    IS 'PROGRAM identity key.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.parameter_cd
    IS 'Code used to identify the parameter.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.required_ind
    IS 'Parameter is required if 1.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.begin_rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.end_rpt_period_id
    IS 'Unique identifier of a reporting period record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.userid
    IS 'User account or source of data that added or updated record.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.add_date
    IS 'Date and time in which record was added.';

COMMENT ON COLUMN camdecmpsaux.program_parameter.update_date
    IS 'Date and time in which record was last updated.';

-- Index: idx_prg_param_begin_rpt_period

-- DROP INDEX camdecmpsaux.idx_prg_param_begin_rpt_period;

CREATE INDEX idx_prg_param_begin_rpt_period
    ON camdecmpsaux.program_parameter USING btree
    (begin_rpt_period_id ASC NULLS LAST);

-- Index: idx_prg_param_end_rpt_period

-- DROP INDEX camdecmpsaux.idx_prg_param_end_rpt_period;

CREATE INDEX idx_prg_param_end_rpt_period
    ON camdecmpsaux.program_parameter USING btree
    (end_rpt_period_id ASC NULLS LAST);

-- Index: idx_prg_param_param_cd

-- DROP INDEX camdecmpsaux.idx_prg_param_param_cd;

CREATE INDEX idx_prg_param_param_cd
    ON camdecmpsaux.program_parameter USING btree
    (parameter_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_prg_param_prg_id

-- DROP INDEX camdecmpsaux.idx_prg_param_prg_id;

CREATE INDEX idx_prg_param_prg_id
    ON camdecmpsaux.program_parameter USING btree
    (prg_id ASC NULLS LAST);
