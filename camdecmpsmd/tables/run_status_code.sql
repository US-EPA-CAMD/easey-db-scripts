CREATE TABLE IF NOT EXISTS camdecmpsmd.run_status_code
(
    run_status_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    run_status_description character varying(1000) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.run_status_code
    IS 'Lookup table for run status flag.';

COMMENT ON COLUMN camdecmpsmd.run_status_code.run_status_cd
    IS 'Code used to identify run status. ';

COMMENT ON COLUMN camdecmpsmd.run_status_code.run_status_description
    IS 'Description of run status code. ';