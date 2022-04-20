-- Table: camdmd.exemption_type_code

-- DROP TABLE camdmd.exemption_type_code;

CREATE TABLE camdmd.exemption_type_code
(
    exemption_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    exemption_type_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_exemption_type_code PRIMARY KEY (exemption_type_cd),
    CONSTRAINT uq_exemption_type_code_desc UNIQUE (exemption_type_description)
);

COMMENT ON TABLE camdmd.exemption_type_code
    IS 'Program Exemption type lookup table.';

COMMENT ON COLUMN camdmd.exemption_type_code.exemption_type_cd
    IS 'Code indicating the type of exemption.';

COMMENT ON COLUMN camdmd.exemption_type_code.exemption_type_description
    IS 'Description of the exemption.';