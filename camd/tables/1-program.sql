-- Table: camd.program

-- DROP TABLE camd.program;

CREATE TABLE IF NOT EXISTS camd.program
(
    prg_id numeric(38,0) NOT NULL,
    prg_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    state_cd character varying(2) COLLATE pg_catalog."default",
    state_reg character varying(20) COLLATE pg_catalog."default",
    fed_ind numeric(1,0) NOT NULL DEFAULT 0,
    tribal_land_cd character varying(7) COLLATE pg_catalog."default",
    trading_ind numeric(1,0) NOT NULL DEFAULT 1,
    indian_country_ind numeric(1,0) NOT NULL DEFAULT 0,
    overdraft_ind numeric(1,0) NOT NULL DEFAULT 0,
    first_sip_year numeric(4,0),
    userid character varying(25) COLLATE pg_catalog."default" NOT NULL,
    add_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone,
    CONSTRAINT pk_program PRIMARY KEY (prg_id),
    CONSTRAINT uq_program_code_state UNIQUE (prg_cd, state_cd),
    CONSTRAINT fk_program_code FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_program_state FOREIGN KEY (state_cd)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_program_tribal_land FOREIGN KEY (tribal_land_cd)
        REFERENCES camdmd.tribal_land_code (tribal_land_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camd.program
    IS 'Identifies regulatory PROGRAM designed to regulate air pollution through emissions trading on either the federal or state level which is implemented by CAMD and supported by SMS/CBS.';

COMMENT ON COLUMN camd.program.prg_id
    IS 'PROGRAM identity key.';

COMMENT ON COLUMN camd.program.prg_cd
    IS 'Code used to identify regulatory PROGRAM applicable to UNIT.';

COMMENT ON COLUMN camd.program.state_cd
    IS 'State abbreviation.';

COMMENT ON COLUMN camd.program.state_reg
    IS 'The State regulation relating to a PROGRAM and applicable to a UNIT.';

COMMENT ON COLUMN camd.program.fed_ind
    IS 'An indicator of whether a regulatory PROGRAM is federal.';

COMMENT ON COLUMN camd.program.tribal_land_cd
    IS 'Tribal Land abbreviation for tribal land in which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM or STAFF is located.';

COMMENT ON COLUMN camd.program.trading_ind
    IS 'Identifies a program as having an allowance trading program.';

COMMENT ON COLUMN camd.program.indian_country_ind
    IS 'Indicates whether or not a program may have units located in Indian Country.';

COMMENT ON COLUMN camd.program.overdraft_ind
    IS 'Indicator that a PROGRAM supports overdraft accounts.';

COMMENT ON COLUMN camd.program.first_sip_year
    IS 'The year of the first SIP.';

COMMENT ON COLUMN camd.program.userid
    IS 'The user name of the person or process that created the record if the Update Date is empty.  Otherwise this is the user name of the person or process that made the last update.';

COMMENT ON COLUMN camd.program.add_date
    IS 'Date the record was created.';

COMMENT ON COLUMN camd.program.update_date
    IS 'Date of the last record update.';

-- Index: idx_program_code

-- DROP INDEX camd.idx_program_code;

CREATE INDEX IF NOT EXISTS idx_program_code
    ON camd.program USING btree
    (prg_cd COLLATE pg_catalog."default" ASC NULLS LAST);

-- Index: idx_program_state

-- DROP INDEX camd.idx_program_state;

CREATE INDEX IF NOT EXISTS idx_program_state
    ON camd.program USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST);
