-- Table: camdmd.program_exemption

-- DROP TABLE camdmd.program_exemption;

CREATE TABLE IF NOT EXISTS camdmd.program_exemption
(
    prg_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    exemption_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_program_exemption PRIMARY KEY (prg_cd, exemption_type_cd),
    CONSTRAINT fk_program_exemption_program FOREIGN KEY (prg_cd)
        REFERENCES camdmd.program_code (prg_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_program_exemption_type FOREIGN KEY (exemption_type_cd)
        REFERENCES camdmd.exemption_type_code (exemption_type_cd) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

COMMENT ON TABLE camdmd.program_exemption
    IS 'Cross check between programs and exemption types.';

COMMENT ON COLUMN camdmd.program_exemption.prg_cd
    IS 'Code indicating the regulatory program.';

COMMENT ON COLUMN camdmd.program_exemption.exemption_type_cd
    IS 'Code indicating the type of exemption.';