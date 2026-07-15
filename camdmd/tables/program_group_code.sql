CREATE TABLE IF NOT EXISTS camdmd.program_group_code
(
    prg_group_cd varchar(8) NOT NULL,
    prg_group_description varchar(1000) NOT NULL,
    PRIMARY KEY (prg_group_cd)
);
COMMENT ON TABLE camdmd.program_group_code
    IS 'Lookup code values for program groups.';
COMMENT ON COLUMN camdmd.program_group_code.prg_group_cd
    IS 'Code used to identify regulatory PROGRAM group.';
COMMENT ON COLUMN camdmd.program_group_code.prg_group_description
    IS 'Name of regulatory PROGRAM group.';