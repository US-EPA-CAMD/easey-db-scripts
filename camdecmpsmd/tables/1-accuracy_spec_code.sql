-- Table: camdecmpsmd.accuracy_spec_code

-- DROP TABLE camdecmpsmd.accuracy_spec_code;

CREATE TABLE IF NOT EXISTS camdecmpsmd.accuracy_spec_code
(
    accuracy_spec_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    accuracy_spec_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pk_accuracy_spec_cd PRIMARY KEY (accuracy_spec_cd)
);


COMMENT ON TABLE camdecmpsmd.accuracy_spec_code
    IS 'Lookup table for accuracy specification code.';

COMMENT ON COLUMN camdecmpsmd.accuracy_spec_code.accuracy_spec_cd
    IS 'Unique code value for a lookup table.';

COMMENT ON COLUMN camdecmpsmd.accuracy_spec_code.accuracy_spec_cd_description
    IS 'Description of lookup code.';