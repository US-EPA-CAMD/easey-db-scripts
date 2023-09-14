CREATE TABLE IF NOT EXISTS camdecmpsmd.severity_code
(
    severity_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    severity_cd_description character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    severity_level numeric(2,0),
    es_type_ind numeric(1,0) NOT NULL DEFAULT 1,
    eval_status_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.severity_code
    IS 'Lookup table for evaluation check severity codes.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_cd
    IS ' Code used to identify the severity of the check result.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_cd_description
    IS ' Description of lookup code.';

COMMENT ON COLUMN camdecmpsmd.severity_code.severity_level
    IS ' The severity level of the severity code.';

COMMENT ON COLUMN camdecmpsmd.severity_code.es_type_ind
    IS '1 indicates that the Severity Code is also an Error Suppression Type.';