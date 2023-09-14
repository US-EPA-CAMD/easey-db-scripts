CREATE TABLE IF NOT EXISTS camdecmpsmd.max_rate_source_code
(
    max_rate_source_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    max_rate_source_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.max_rate_source_code
    IS 'Lookup table for source of maximum fuel flow value.';

COMMENT ON COLUMN camdecmpsmd.max_rate_source_code.max_rate_source_cd
    IS 'Code used to identify the source of maximum fuel flow. ';

COMMENT ON COLUMN camdecmpsmd.max_rate_source_code.max_rate_source_cd_description
    IS 'Description of lookup code. ';