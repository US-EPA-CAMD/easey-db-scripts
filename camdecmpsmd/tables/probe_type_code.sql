CREATE TABLE IF NOT EXISTS camdecmpsmd.probe_type_code
(
    probe_type_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    probe_type_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.probe_type_code
    IS 'Lookup table of reference methods for probe types.';

COMMENT ON COLUMN camdecmpsmd.probe_type_code.probe_type_cd
    IS 'Code used to identify a probe type. ';

COMMENT ON COLUMN camdecmpsmd.probe_type_code.probe_type_cd_description
    IS 'Description of probe type code. ';