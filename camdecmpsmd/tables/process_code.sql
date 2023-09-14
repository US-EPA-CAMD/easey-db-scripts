CREATE TABLE IF NOT EXISTS camdecmpsmd.process_code
(
    process_cd character varying(7) COLLATE pg_catalog."default" NOT NULL,
    process_cd_description character varying(1000) COLLATE pg_catalog."default",
    process_cd_name character varying(100) COLLATE pg_catalog."default",
    parameter_group_override_cd character varying(7) COLLATE pg_catalog."default",
    process_group_cd character varying(7) COLLATE pg_catalog."default"
);

COMMENT ON TABLE camdecmpsmd.process_code
    IS 'Lookup table for evaluation check process codes.';

COMMENT ON COLUMN camdecmpsmd.process_code.process_cd
    IS ' Code used to identify the check process.';

COMMENT ON COLUMN camdecmpsmd.process_code.process_cd_description
    IS ' Description of lookup code.';