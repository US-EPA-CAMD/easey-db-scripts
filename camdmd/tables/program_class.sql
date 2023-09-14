CREATE TABLE IF NOT EXISTS camdmd.program_class
(
    prg_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    class_cd character varying(7) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdmd.program_class
    IS 'Cross check between programs and exemption types.';

COMMENT ON COLUMN camdmd.program_class.prg_cd
    IS 'Code indicating the regulatory program.';

COMMENT ON COLUMN camdmd.program_class.class_cd
    IS 'Code indicating the program class.';
