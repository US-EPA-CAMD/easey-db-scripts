-- Table: camdmd.program_class

-- DROP TABLE camdmd.program_class;

CREATE TABLE IF NOT EXISTS camdmd.program_class
(
    prg_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    class_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_program_class PRIMARY KEY (prg_cd, class_cd),
    CONSTRAINT fk_program_class_class FOREIGN KEY (class_cd)
        REFERENCES camdmd.class_code (class_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_program_class_program FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdmd.program_class
    IS 'Cross check between programs and exemption types.';

COMMENT ON COLUMN camdmd.program_class.prg_cd
    IS 'Code indicating the regulatory program.';

COMMENT ON COLUMN camdmd.program_class.class_cd
    IS 'Code indicating the program class.';