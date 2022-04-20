-- Table: camdecmpsmd.modc_code

-- DROP TABLE camdecmpsmd.modc_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.modc_code
(
    modc_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    modc_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_modc_code PRIMARY KEY (modc_cd)
);

COMMENT ON TABLE camdecmpsmd.modc_code
    IS 'Lookup table of method of determination codes used to identify the method by which the parameter was determined for the hour.';

COMMENT ON COLUMN camdecmpsmd.modc_code.modc_cd
    IS 'Code used to identify the method of determination. ';

COMMENT ON COLUMN camdecmpsmd.modc_code.modc_description
    IS 'Description of MODC code. ';