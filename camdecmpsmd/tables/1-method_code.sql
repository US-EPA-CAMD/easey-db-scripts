-- Table: camdecmpsmd.method_code

-- DROP TABLE camdecmpsmd.method_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.method_code
(
    method_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    method_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_method_code PRIMARY KEY (method_cd)
);

COMMENT ON TABLE camdecmpsmd.method_code
    IS 'Lookup table of monitoring methods. Record Type 585.';

COMMENT ON COLUMN camdecmpsmd.method_code.method_cd
    IS 'Code used to identify the monitoring methodology. ';

COMMENT ON COLUMN camdecmpsmd.method_code.method_cd_description
    IS 'Description of method code. ';