CREATE TABLE IF NOT EXISTS camdecmpsmd.injection_protocol_code
(
    injection_protocol_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    injection_protocol_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.injection_protocol_code
    IS 'Lookup table for injection protocol code.';

COMMENT ON COLUMN camdecmpsmd.injection_protocol_code.injection_protocol_cd
    IS 'Code used to identify the injection protocol. ';

COMMENT ON COLUMN camdecmpsmd.injection_protocol_code.injection_protocol_description
    IS 'Description of lookup code. ';