-- Table: camdmd.program_group_code

-- DROP TABLE camdmd.program_group_code;

CREATE TABLE IF NOT EXISTS camdmd.program_group_code
(
    prg_group_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    prg_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_program_group_code PRIMARY KEY (prg_group_cd),
    CONSTRAINT uq_program_group_code_desc UNIQUE (prg_group_description)
);

COMMENT ON TABLE camdmd.program_group_code
    IS 'Lookup code values for program groups.';

COMMENT ON COLUMN camdmd.program_group_code.prg_group_cd
    IS 'Code used to identify regulatory PROGRAM group.';

COMMENT ON COLUMN camdmd.program_group_code.prg_group_description
    IS 'Name of regulatory PROGRAM group.';