-- Table: camdecmpsmd.default_source_code

-- DROP TABLE camdecmpsmd.default_source_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.default_source_code
(
    default_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    default_source_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_default_source_code PRIMARY KEY (default_source_cd)
);

COMMENT ON TABLE camdecmpsmd.default_source_code
    IS 'Lookup table of identifying the source of the default value.  Record Type 531.';

COMMENT ON COLUMN camdecmpsmd.default_source_code.default_source_cd
    IS 'Code used to identify the source of the default value. ';

COMMENT ON COLUMN camdecmpsmd.default_source_code.default_source_cd_description
    IS 'Description of lookup code. ';