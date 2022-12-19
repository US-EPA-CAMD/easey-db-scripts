-- Table: camdmd.county_code

-- DROP TABLE camdmd.county_code;

CREATE TABLE IF NOT EXISTS camdmd.county_code
(
    county_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    county_number character varying(3) COLLATE pg_catalog."default" NOT NULL,
    county_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    state_cd character varying(2) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_county_code PRIMARY KEY (county_cd),
    CONSTRAINT fk_county_code_state FOREIGN KEY (state_cd)
        REFERENCES camdmd.state_code (state_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdmd.county_code
    IS 'Look up table for county codes.';

COMMENT ON COLUMN camdmd.county_code.county_cd
    IS 'Concatenation of State and county number.';

COMMENT ON COLUMN camdmd.county_code.county_number
    IS 'The FIPS county code/number for the county in which the facility is located.';

COMMENT ON COLUMN camdmd.county_code.county_name
    IS 'Full description of county code.';

COMMENT ON COLUMN camdmd.county_code.state_cd
    IS 'State abbreviation for state in which FACILITY, CONTACT, AGENCY, ACCOUNT REQUEST, PROGRAM, or STAFF is located.';

-- Index: idx_county_code_state

-- DROP INDEX camdmd.idx_county_code_state;

CREATE INDEX IF NOT EXISTS idx_county_code_state
    ON camdmd.county_code USING btree
    (state_cd COLLATE pg_catalog."default" ASC NULLS LAST);