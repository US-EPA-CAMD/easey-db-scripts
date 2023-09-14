CREATE TABLE IF NOT EXISTS camdecmpsmd.gas_type_code
(
    gas_type_cd character varying(5) COLLATE pg_catalog."default" NOT NULL,
    gas_type_description character varying(200) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.gas_type_code
    IS 'Lookup table of gas type codes.';

COMMENT ON COLUMN camdecmpsmd.gas_type_code.gas_type_cd
    IS 'Code used to identify the contents of a calibration gas cylinder';

COMMENT ON COLUMN camdecmpsmd.gas_type_code.gas_type_description
    IS 'Description of the contents of a calibration gas cylinder';