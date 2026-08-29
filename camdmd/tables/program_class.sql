CREATE TABLE IF NOT EXISTS camdmd.program_class
(
    prg_cd varchar(7) NOT NULL,
    class_cd varchar(7) NOT NULL,
    PRIMARY KEY (prg_cd, class_cd)
);
COMMENT ON TABLE camdmd.program_class
    IS 'Cross check between programs and exemption types.';
COMMENT ON COLUMN camdmd.program_class.prg_cd
    IS 'Code indicating the regulatory program.';
COMMENT ON COLUMN camdmd.program_class.class_cd
    IS 'Code indicating the program class.';