CREATE TABLE IF NOT EXISTS camdecmpsmd.es_reason_code
(
    es_reason_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    es_reason_description character varying(1000) COLLATE pg_catalog."default" NOT NULL
);

COMMENT ON TABLE camdecmpsmd.es_reason_code
    IS 'Lookup table for error suppression reason codes.';

COMMENT ON COLUMN camdecmpsmd.es_reason_code.es_reason_cd
    IS ' The reason for the suppression.';

COMMENT ON COLUMN camdecmpsmd.es_reason_code.es_reason_description
    IS ' The reason description.';