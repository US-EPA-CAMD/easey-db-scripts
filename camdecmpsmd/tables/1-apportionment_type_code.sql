-- Table: camdecmpsmd.apportionment_type_code

-- DROP TABLE camdecmpsmd.apportionment_type_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.apportionment_type_code
(
    apportionment_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    apportionment_type_description character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT apportionment_type_code_pk PRIMARY KEY (apportionment_type_cd),
    CONSTRAINT apportionment_type_code_uq UNIQUE (apportionment_type_description)
);

COMMENT ON TABLE camdecmpsmd.apportionment_type_code
    IS 'Lookup table of codes that indicate the apportionment type of an emissions report.';

COMMENT ON COLUMN camdecmpsmd.apportionment_type_code.apportionment_type_cd
    IS 'Code used to indicate the apportionment type of an emissions report.';

COMMENT ON COLUMN camdecmpsmd.apportionment_type_code.apportionment_type_description
    IS 'Description of apportionment type code.';