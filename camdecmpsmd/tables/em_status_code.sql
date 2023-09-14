CREATE TABLE IF NOT EXISTS camdecmpsmd.em_status_code
(
    em_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    em_status_cd_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.em_status_code
    IS 'Lookup table for emission submission status codes.';

COMMENT ON COLUMN camdecmpsmd.em_status_code.em_status_cd
    IS ' Code used to identify the emissions status.';

COMMENT ON COLUMN camdecmpsmd.em_status_code.em_status_cd_description
    IS ' Description of lookup code.';