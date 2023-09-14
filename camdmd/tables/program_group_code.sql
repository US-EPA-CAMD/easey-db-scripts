CREATE TABLE IF NOT EXISTS camdmd.program_group_code
(
    prg_group_cd character varying(8) COLLATE pg_catalog."default" NOT NULL,
    prg_group_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.program_group_code
    IS 'Lookup code values for program groups.';

COMMENT ON COLUMN camdmd.program_group_code.prg_group_cd
    IS 'Code used to identify regulatory PROGRAM group.';

COMMENT ON COLUMN camdmd.program_group_code.prg_group_description
    IS 'Name of regulatory PROGRAM group.';
