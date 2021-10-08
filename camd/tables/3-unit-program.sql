CREATE TABLE camd.unit_program
(
    up_id numeric(38,0) NOT NULL,
    unit_id numeric(38,0) NOT NULL,
    prg_id numeric(38,0) NOT NULL,
    prg_cd character varying(7) COLLATE pg_catalog."default",
    class_cd character varying(7) COLLATE pg_catalog."default",
    app_status_cd character varying(7) COLLATE pg_catalog."default",
    optin_ind numeric(1,0) NOT NULL DEFAULT 0,
    def_ind numeric(1,0) NOT NULL DEFAULT 0,
    def_end_date date,
    up_comment character varying(1000) COLLATE pg_catalog."default",
    unit_monitor_cert_begin_date date,
    unit_monitor_cert_deadline date,
    emissions_recording_begin_date date,
    trueup_begin_year numeric(4,0),
    end_date date,
    non_egu_ind numeric(1,0) NOT NULL DEFAULT 0,
    nonstandard_cd character varying(7) COLLATE pg_catalog."default",
    nonstandard_comment character varying(1000) COLLATE pg_catalog."default",
    so2_affect_year numeric(4,0),
    so2_phase character varying(1) COLLATE pg_catalog."default",
    userid character varying(8) COLLATE pg_catalog."default" NOT NULL,
    add_date date NOT NULL,
    update_date date,
    CONSTRAINT pk_unit_program PRIMARY KEY (up_id),
    CONSTRAINT uq_unit_program UNIQUE (unit_id, prg_id),
    CONSTRAINT fk_unit_program_applic FOREIGN KEY (app_status_cd)
        REFERENCES camdmd.applicability_status_code (app_status_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_program_class FOREIGN KEY (class_cd, prg_cd)
        REFERENCES camdmd.program_class (class_cd, prg_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_program_id FOREIGN KEY (prg_id)
        REFERENCES camd.program (prg_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_program_nonstandard_cd FOREIGN KEY (nonstandard_cd)
        REFERENCES camdmd.nonstandard_code (nonstandard_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_unit_program_unit FOREIGN KEY (unit_id)
        REFERENCES camd.unit (unit_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.unit_program
    IS 'The specific PROGRAM in which the UNIT is or may be participating.';

COMMENT ON COLUMN camd.unit_program.up_id
    IS 'UNIT and PROGRAM relationship identity key.';

COMMENT ON COLUMN camd.unit_program.unit_id
    IS 'Identity key for UNIT table.';

COMMENT ON COLUMN camd.unit_program.prg_id
    IS 'PROGRAM identity key.';

COMMENT ON COLUMN camd.unit_program.prg_cd
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.  ';

COMMENT ON COLUMN camd.unit_program.class_cd
    IS 'The regulatory category with respect to a specific PROGRAM for a UNIT.';

COMMENT ON COLUMN camd.unit_program.app_status_cd
    IS 'Status of applicability (Unknown, Interim, Final). ';

COMMENT ON COLUMN camd.unit_program.optin_ind
    IS 'Indicator that UNIT is an opt-in unit.';

COMMENT ON COLUMN camd.unit_program.def_ind
    IS 'An indicator that a UNIT has not operated since the day on which it was affected by the PROGRAM.';

COMMENT ON COLUMN camd.unit_program.def_end_date
    IS 'The date on which the UNIT became operational after the program participation date and was therefore subject to the PROGRAM''s regulatory requirements.';

COMMENT ON COLUMN camd.unit_program.up_comment
    IS 'Comment for unit program record.';

COMMENT ON COLUMN camd.unit_program.unit_monitor_cert_begin_date
    IS 'Date beginning timeline for completion of certification testing.';

COMMENT ON COLUMN camd.unit_program.unit_monitor_cert_deadline
    IS 'Date by which monitor certification must be completed.';

COMMENT ON COLUMN camd.unit_program.emissions_recording_begin_date
    IS 'Date a unit first begins recording hourly emissions data.';

COMMENT ON COLUMN camd.unit_program.trueup_begin_year
    IS 'First year the unit was expected for true up.';

COMMENT ON COLUMN camd.unit_program.end_date
    IS 'Date on which a relationship or an activity ended.';

COMMENT ON COLUMN camd.unit_program.non_egu_ind
    IS 'Identifies whether unit is electric-generating.';

COMMENT ON COLUMN camd.unit_program.nonstandard_cd
    IS 'Code used to identify type of nonstandard unit program situation.';

COMMENT ON COLUMN camd.unit_program.nonstandard_comment
    IS 'Comment for nonstandard unit program situation.';

COMMENT ON COLUMN camd.unit_program.so2_affect_year
    IS 'LEGACY - First year in which UNIT was affected by SO2 emission limits under Part 72.';

COMMENT ON COLUMN camd.unit_program.so2_phase
    IS 'LEGACY - Indicator of whether a UNIT was affected by SO2 allowance holding requirements in 1995 (Phase I) or 2000 (Phase II).';

COMMENT ON COLUMN camd.unit_program.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.unit_program.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.unit_program.update_date
    IS 'Date of the last record update.';
-- Index: idx_unit_program_applic

-- DROP INDEX camd.idx_unit_program_applic;

CREATE INDEX idx_unit_program_applic
    ON camd.unit_program USING btree
    (app_status_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_class

-- DROP INDEX camd.idx_unit_program_class;

CREATE INDEX idx_unit_program_class
    ON camd.unit_program USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST, class_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_id

-- DROP INDEX camd.idx_unit_program_id;

CREATE INDEX idx_unit_program_id
    ON camd.unit_program USING btree
    (prg_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_nonstandard

-- DROP INDEX camd.idx_unit_program_nonstandard;

CREATE INDEX idx_unit_program_nonstandard
    ON camd.unit_program USING btree
    (nonstandard_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_unit

-- DROP INDEX camd.idx_unit_program_unit;

CREATE INDEX idx_unit_program_unit
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_unit_class

-- DROP INDEX camd.idx_unit_program_unit_class;

CREATE INDEX idx_unit_program_unit_class
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST, class_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unit_program_unit_program

-- DROP INDEX camd.idx_unit_program_unit_program;

CREATE INDEX idx_unit_program_unit_program
    ON camd.unit_program USING btree
    (unit_id ASC NULLS LAST, prg_cd COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;